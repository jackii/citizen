namespace :citizen_budget_model do
  desc 'Pulls out strings marked for translations'
  task translations: :environment do
    require 'citizen_budget_model/gettext_helper'
    require 'citizen_budget_model/js_parser'

    GetText::Tools::XGetText.add_parser(CitizenBudgetModel::JsParser)
    keys = CitizenBudgetModel::GetTextHelper.messages('app/**/*.{erb,rb,js}')

    # Unless the backend already has a key, add a default to the default locale.
    data = {}
    keys.each do |key|
      unless I18n.backend.exists?(I18n.default_locale, key)
        data[key] = key
      end
    end

    unless data.empty?
      if ENV['CONFIRM']
        puts "Adding:"
        puts data.keys.sort
        puts 'Continue? (y/n)'
        unless STDIN.gets == "y\n"
          next
        end
      end

      I18n.backend.store_translations(I18n.default_locale, data, escape: false)
      puts "#{data.size} added"
    end

    # List all the keys to be deleted.
    delete = []
    store = I18n.backend.backends.first.store
    store.keys.each do |k|
      key = k.split('.', 2)[1]
      unless keys.include?(key)
        delete << k
      end
    end

    # Delete keys that are no longer extant.
    unless delete.empty?
      if ENV['CONFIRM']
        puts "Deleting:"
        puts delete.sort
        puts 'Continue? (y/n)'
        unless STDIN.gets == "y\n"
          next
        end
      end

      number = store.del(delete)
      puts "#{number} deleted"
    end
  end
end
