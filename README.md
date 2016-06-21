We are adding a few new features to the ready reckoner application under the
sensitivity analysis tab

Formula editor

1) Admin will be able to edit the formula using hands on table for a specific impact
2) Admin will be be able to use the mathematical formulas built in to hands on table
3) Admin will be able to reference the variables set in the Variables model
4) Admin will be able to edit the formula used for Year 1, Year 2, Year 5
4b) Admin will be able to refernce the previous year's formula in a cell.  Basically we are building a Microsoft Excel like interface.

The formula that is set will be used by the front end sliders

Formula test field

1) Admin will be able to supply values for the variables in a given formula and see what the numeric result will be
  If a formula was 'ax+b', a user could enter a = 5, x = 5, b=5 and get the answer 30

Global formula for sensitivity analysis table

1) Admin will be able to set a default formula that will be used for all impacts in a sensistivity analysis table

Custom formula for specific impact

1) Admin will be able to set a formula for an impact that will be able to override the global formula for that impact

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

    heroku apps:create
    heroku config:set SECRET_KEY_BASE=`bundle exec rake secret`
    heroku config:set ACTION_MAILER_HOST=www.example.com
    heroku config:set DEVISE_MAILER_SENDER=noreply@example.com

## Testing

    bundle exec rake db:drop RAILS_ENV=test
    bundle exec rake db:create RAILS_ENV=test
    bundle exec rake db:migrate RAILS_ENV=test
    bundle exec rake
    bundle exec guard

Copyright (c) 2014 Open North Inc., released under the MIT license
