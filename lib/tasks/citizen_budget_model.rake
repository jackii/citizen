namespace :citizen_budget_model do
  desc 'Pulls out strings marked for translations'
  task translations: :environment do
    require 'citizen_budget_model/gettext_helper'
    require 'citizen_budget_model/js_parser'

    def confirm(message, objects)
      unless objects.empty?
        if ENV['CONFIRM']
          puts message
          puts objects.sort
          puts 'Continue? (y/n)'
          unless STDIN.gets == "y\n"
            return
          end
        end
        yield
      end
    end

    GetText::Tools::XGetText.add_parser(CitizenBudgetModel::JsParser)

    keys = CitizenBudgetModel::GetTextHelper.messages('app/**/*.{erb,rb,js}')

    # Unless the backend already has a key, add a default to the default locale.
    keys_to_add = keys.reject do |key|
      I18n.backend.exists?(I18n.default_locale, key)
    end

    store = I18n.backend.backends.first.store

    # Delete keys that are no longer extant.
    keys_to_delete = store.keys.reject do |k|
      keys.include?(k.split('.', 2)[1])
    end

    confirm('Adding:', keys_to_add) do
      I18n.backend.store_translations(I18n.default_locale, Hash[keys_to_add.zip(keys_to_add)], escape: false)
      puts "#{data.size} added"

      confirm('Deleting:', keys_to_delete) do
        number = store.del(keys_to_delete)
        puts "#{number} deleted"
      end
    end
  end
end
