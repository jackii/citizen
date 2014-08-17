# @see https://github.com/grosser/fast_gettext#2-add-a-translation-repository
# @see https://github.com/grosser/gettext_i18n_rails#locales--initialisation
FastGettext.add_text_domain('citizen_budget_model', path: 'po', type: :po) # same path as gettext gem
FastGettext.default_text_domain = 'citizen_budget_model'
FastGettext.default_available_locales = ['en-CA', 'fr-CA']
