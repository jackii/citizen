# Citizen Budget: Model

[![Build Status](https://secure.travis-ci.org/opennorth/citizen_budget_model.png)](http://travis-ci.org/opennorth/citizen_budget_model)
[![Dependency Status](https://gemnasium.com/opennorth/citizen_budget_model.png)](https://gemnasium.com/opennorth/citizen_budget_model)
[![Coverage Status](https://coveralls.io/repos/opennorth/citizen_budget_model/badge.png?branch=master)](https://coveralls.io/r/opennorth/citizen_budget_model)
[![Code Climate](https://codeclimate.com/github/opennorth/citizen_budget_model.png)](https://codeclimate.com/github/opennorth/citizen_budget_model)

## Installation

    gem 'citizen_budget_model'

In `app/assets/application.css`:

    *= require citizen_budget_model/application

In `app/assets/application.js`:

    //= require jquery
    //= require jquery_ujs

In `config/application.rb`:

    config.i18n.available_locales = ['en-CA', 'fr-CA']
    config.i18n.default_locale = 'en-CA'
    config.i18n.fallbacks = {'en-CA' => ['en-CA', :en, 'fr-CA', :fr], 'fr-CA' => ['fr-CA', :fr, 'en-CA', :en]}
    config.i18n.enforce_available_locales = false

In `config/routes.rb`:

    mount CitizenBudgetModel::Engine => '/'

## Testing

    bundle exec RAILS_ENV=test rake db:drop
    bundle exec RAILS_ENV=test rake db:create
    bundle exec RAILS_ENV=test rake db:migrate
    bundle exec rake
    bundle exec guard

## Bugs? Questions?

This engine's main repository is on GitHub: [http://github.com/opennorth/citizen_budget_model](http://github.com/opennorth/citizen_budget_model), where your contributions, forks, bug reports, feature requests, and feedback are greatly welcomed.

Copyright (c) 2014 Open North Inc., released under the MIT license
