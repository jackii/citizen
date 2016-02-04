# -*- encoding: utf-8 -*-
require File.expand_path('../lib/citizen_budget_model/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = "citizen_budget_model"
  s.version     = CitizenBudgetModel::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Open North"]
  s.email       = ["info@opennorth.ca"]
  s.homepage    = "http://github.com/opennorth/citizen_budget_model"
  s.summary     = %q{The Citizen Budget budget simulation model}
  s.license     = 'MIT'

  s.files         = Dir["{app,config,db,lib}/**/*"] + ["LICENSE", "Rakefile", "README.md"]
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")

  s.add_dependency('rails', '~> 4.1.0')
  s.add_dependency('i18n', '<= 0.7') # 0.7 fallbacks can't reference unavailable locales
  s.add_dependency('pg') # uses array column types

  # ActiveRecord
  s.add_dependency('acts_as_list', '~> 0.4.0')
  s.add_dependency('paranoia', '~> 2.0.2')

  # Authentication
  s.add_dependency('devise', '~> 3.5.4')

  # Internationalization
  s.add_dependency('globalize', '~> 4.0.2')
  s.add_dependency('globalize-accessors', '~> 0.1.5')
  s.add_dependency('redis')

  # Testing
  s.add_development_dependency('coveralls')
  s.add_development_dependency('database_cleaner', '~> 1.2')
  s.add_development_dependency('factory_girl_rails', '~> 4.1')
  s.add_development_dependency('guard-bundler', '~> 2.0')
  s.add_development_dependency('guard-rspec', '~> 4.3')
  s.add_development_dependency('rspec-rails', '~> 3.0')
  s.add_development_dependency('shoulda-matchers', '~> 2.7')

  # Development
  s.add_development_dependency('pry-rails')
  s.add_development_dependency('gettext')

  # Optional
  #s.add_development_dependency('rails-i18n', '~> 4.0.0')
  s.add_development_dependency('devise-i18n', '~> 0.12.0')
  s.add_development_dependency('jquery-rails', '~> 3.1')
end
