namespace :citizen_budget_model do
  desc 'Pulls out strings marked for translations'
  task translations: :environment do
    require 'citizen_budget_model/js_parser'
    require 'gettext/tools/parser/erb'
    require 'gettext/tools/parser/ruby'

    parsers = {
      '.erb' => GetText::ErbParser,
      '.rb' => GetText::RubyParser,
      '.js' => CitizenBudgetModel::JsParser,
    }

    keys = []

    # Add messages from the engine and the app.
    pattern = 'app/**/*.{erb,rb,js}'
    Dir.glob([CitizenBudgetModel::Engine.root.join(pattern), Rails.root.join(pattern)]) do |filename|
      parsers[File.extname(filename)].parse(filename).each do |po_entry|
        keys << po_entry.msgid
      end
    end

    # Add the locale identifiers.
    I18n.available_locales.each do |locale|
      keys << locale.to_s
    end

    # Add User model name and attribute names.
    keys << CitizenBudgetModel::User.model_name.human
    %w(organization_id email password password_confirmation).each do |attribute_name|
      keys << CitizenBudgetModel::User.human_attribute_name(attribute_name)
    end

    # Add other model names and attribute names.
    %w(Organization Simulator Section Question).each do |constant|
      klass = CitizenBudgetModel.const_get(constant)

      keys << klass.model_name.human
      (klass.attribute_names + klass.translated_attribute_names - %w(id position deleted_at created_at updated_at)).each do |attribute_name|
        keys << klass.human_attribute_name(attribute_name)
      end
    end

    # Add the virtual Question attribute names.
    %w(minimum maximum step).each do |attribute_name|
      keys << CitizenBudgetModel::Question.human_attribute_name(attribute_name)
    end

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
          return
        end
      end

      I18n.backend.store_translations(I18n.default_locale, data, escape: false)
    end

    # List all the keys in the backend.
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
          return
        end
      end

      puts "#{store.del(delete)} deleted"
    end
  end
end
