# Citizen Budget: Model

[![Build Status](https://secure.travis-ci.org/opennorth/citizen_budget_model.png)](http://travis-ci.org/opennorth/citizen_budget_model)
[![Dependency Status](https://gemnasium.com/opennorth/citizen_budget_model.png)](https://gemnasium.com/opennorth/citizen_budget_model)
[![Code Climate](https://codeclimate.com/github/opennorth/citizen_budget_model.png)](https://codeclimate.com/github/opennorth/citizen_budget_model)

## Installation

    gem 'fast_gettext', :git => 'https://github.com/jpmckinney/fast_gettext.git', :branch => 'rails4'
    gem 'citizen_budget_model'

## Internationalization

Add a new locale:

    bundle exec rake gettext:po:add[locale]

Update po files:

    bundle exec rake gettext:po:update

Update mo files:

    bundle exec rake gettext:mo:update

Create a pot file:

    bundle exec rake gettext:pot:create

## Testing

    bundle exec RAILS_ENV=test rake db:drop
    bundle exec RAILS_ENV=test rake db:create
    bundle exec RAILS_ENV=test rake db:migrate
    bundle exec rake
    bundle exec guard

## Bugs? Questions?

This engine's main repository is on GitHub: [http://github.com/opennorth/citizen_budget_model](http://github.com/opennorth/citizen_budget_model), where your contributions, forks, bug reports, feature requests, and feedback are greatly welcomed.

Copyright (c) 2014 Open North Inc., released under the MIT license
