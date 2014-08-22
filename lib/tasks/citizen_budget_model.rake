namespace :citizen_budget_model do
  desc 'Pulls out strings marked for translations'
  task translations: :environment do
    require 'gettext/tools/parser/erb'
    require 'gettext/tools/parser/ruby'

    parsers = {
      '.erb' => GetText::ErbParser,
      '.rb' => GetText::RubyParser,
    }

    keys = []

    Dir.glob('../../app/**/*.{erb,rb}') do |filename|
      parsers[File.extname(filename)].parse(filename).each do |poentry|
        keys << poentry.msgid # if we want to scope by file: poentry.references.sub('../../', '').split(':')[0]
      end
    end

    I18n.available_locales.each do |locale|
      keys << locale.to_s
    end

    keys << CitizenBudgetModel::User.model_name.human
    keys += %w(organization_id email password password_confirmation)

    %w(Organization Simulator Section Question).each do |constant|
      klass = CitizenBudgetModel.const_get(constant)

      keys << klass.model_name.human
      keys += klass.attribute_names - %w(id deleted_at created_at updated_at)
    end

    data = {}

    keys.each do |key|
      unless I18n.backend.exists?(I18n.default_locale, key)
        data[key] = key
      end
    end

    I18n.backend.store_translations(I18n.default_locale, data, escape: true)

    # @todo Delete any other keys
  end
end
