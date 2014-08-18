# @see https://github.com/grosser/fast_gettext#2-add-a-translation-repository
# @see https://github.com/grosser/gettext_i18n_rails#locales--initialisation
# @todo Using the DB causes test failures.
# require 'fast_gettext/translation_repository/db'
# FastGettext::TranslationRepository::Db.require_models
# FastGettext.add_text_domain('citizen_budget_model', type: :db)
FastGettext.add_text_domain('citizen_budget_model', path: File.expand_path('../../po', __dir__), type: :po) # same path as gettext gem
FastGettext.default_text_domain = 'citizen_budget_model'
FastGettext.default_available_locales = ['en_CA', 'fr_CA']
