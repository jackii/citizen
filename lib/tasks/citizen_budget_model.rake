namespace :citizen_budget_model do
  desc 'Pulls out strings marked for translations'
  task translations: :environment do
    require 'gettext/tools/parser/erb'
    require 'gettext/tools/parser/ruby'

    parsers = {
      '.erb' => GetText::ErbParser,
      '.rb' => GetText::RubyParser,
    }

    data = {}

    Dir.glob('../../app/**/*.{erb,rb}') do |filename|
      parsers[File.extname(filename)].parse(filename).each do |poentry|
        key = poentry.msgid # in case we want to scope by file: poentry.references.sub('../../', '').split(':')[0]
        unless I18n.backend.exists?(I18n.default_locale, key)
          data[key] = key
        end
      end
    end

    I18n.backend.store_translations(I18n.default_locale, data, escape: true)
  end
end
