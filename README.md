# Citizen Budget: Model

[![Build Status](https://secure.travis-ci.org/opennorth/citizen_budget_model.png)](http://travis-ci.org/opennorth/citizen_budget_model)
[![Dependency Status](https://gemnasium.com/opennorth/citizen_budget_model.png)](https://gemnasium.com/opennorth/citizen_budget_model)
[![Coverage Status](https://coveralls.io/repos/opennorth/citizen_budget_model/badge.png?branch=master)](https://coveralls.io/r/opennorth/citizen_budget_model)
[![Code Climate](https://codeclimate.com/github/opennorth/citizen_budget_model.png)](https://codeclimate.com/github/opennorth/citizen_budget_model)

## Installation

### Basic

In `Gemfile`:

    gem 'citizen_budget_model'

In `config/routes.rb`:

    mount CitizenBudgetModel::Engine => '/'

In `config/environments/production.rb`:

    config.action_mailer.default_url_options = {host: ENV['ACTION_MAILER_HOST']}

### Internationalization

Set your locales in `config/application.rb`, for example:

    config.i18n.available_locales = ['en-CA', 'fr-CA']
    config.i18n.default_locale = 'en-CA'
    config.i18n.fallbacks = {'en-CA' => ['en-CA', :en, 'fr-CA', :fr], 'fr-CA' => ['fr-CA', :fr, 'en-CA', :en]}
    config.i18n.enforce_available_locales = false

If you are using the engine's admin views:

    gem 'jquery-rails'

To fully support multiple languages, in `Gemfile`:

    gem 'gettext'
    gem 'rails-i18n', '~> 4.0.0'
    gem 'devise-i18n', '~> 0.10.4'

You can then add translations to the Redis backend:

    bundle exec rake citizen_budget_model:translations

## Testing

    bundle exec RAILS_ENV=test rake db:drop
    bundle exec RAILS_ENV=test rake db:create
    bundle exec RAILS_ENV=test rake db:migrate
    bundle exec rake
    bundle exec guard

## Deployment

    heroku config:set DEVISE_MAILER_SENDER=noreply@example.com

## Bugs? Questions?

This engine's main repository is on GitHub: [http://github.com/opennorth/citizen_budget_model](http://github.com/opennorth/citizen_budget_model), where your contributions, forks, bug reports, feature requests, and feedback are greatly welcomed.

Copyright (c) 2014 Open North Inc., released under the MIT license
