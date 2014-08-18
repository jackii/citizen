# @see https://github.com/grosser/fast_gettext#2-add-a-translation-repository
# @see https://github.com/grosser/gettext_i18n_rails#locales--initialisation
require 'fast_gettext/translation_repository/db'
FastGettext::TranslationRepository::Db.require_models
FastGettext.add_text_domain('citizen_budget_model', type: :db)
FastGettext.default_text_domain = 'citizen_budget_model'
FastGettext.default_available_locales = ['en-CA', 'fr-CA']
