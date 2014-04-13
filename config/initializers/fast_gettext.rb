# Uses the same path as the gettext gem.
# @see https://github.com/grosser/fast_gettext#2-add-a-translation-repository
# @see https://github.com/grosser/gettext_i18n_rails#locales--initialisation
FastGettext.add_text_domain('citizen_budget_model', path: 'po', type: :po)
FastGettext.default_text_domain = 'citizen_budget_model'
FastGettext.default_available_locales = ['en_CA', 'fr_CA']
