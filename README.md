# Citizen Budget: Model

[![Gem Version](https://badge.fury.io/rb/citizen_budget_model.svg)](http://badge.fury.io/rb/citizen_budget_model)
[![Build Status](https://secure.travis-ci.org/opennorth/citizen_budget_model.png)](http://travis-ci.org/opennorth/citizen_budget_model)
[![Dependency Status](https://gemnasium.com/opennorth/citizen_budget_model.png)](https://gemnasium.com/opennorth/citizen_budget_model)
[![Coverage Status](https://coveralls.io/repos/opennorth/citizen_budget_model/badge.png?branch=master)](https://coveralls.io/r/opennorth/citizen_budget_model)
[![Code Climate](https://codeclimate.com/github/opennorth/citizen_budget_model.png)](https://codeclimate.com/github/opennorth/citizen_budget_model)

## Usage

In `Gemfile`:

    gem 'citizen_budget_model'

In `config/routes.rb`:

    mount CitizenBudgetModel::Engine => '/'

In `config/environments/production.rb`:

    config.action_mailer.default_url_options = {host: ENV['ACTION_MAILER_HOST']}

If you are using the engine's admin views:

    gem 'jquery-rails'

### Internationalization

Set your locales in `config/application.rb`, for example:

    config.i18n.available_locales = ['en-CA', 'fr-CA']
    config.i18n.default_locale = 'en-CA'
    config.i18n.fallbacks = {'en-CA' => ['en-CA', :en, 'fr-CA', :fr], 'fr-CA' => ['fr-CA', :fr, 'en-CA', :en]}
    config.i18n.enforce_available_locales = false

To fully support multiple languages, in `Gemfile`:

    gem 'gettext'
    gem 'rails-i18n', '~> 4.0.0'
    gem 'devise-i18n', '~> 0.10.4'

You can then add translations to the Redis backend:

    bundle exec rake citizen_budget_model:translations CONFIRM=true

### Deployment

    heroku config:set SECRET_KEY_BASE=`bundle exec rake secret`
    heroku config:set ACTION_MAILER_HOST=www.example.com
    heroku config:set DEVISE_MAILER_SENDER=noreply@example.com

## Testing

    bundle exec RAILS_ENV=test rake db:drop
    bundle exec RAILS_ENV=test rake db:create
    bundle exec RAILS_ENV=test rake db:migrate
    bundle exec rake
    bundle exec guard

Copyright (c) 2014 Open North Inc., released under the MIT license
