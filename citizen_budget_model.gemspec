$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "citizen_budget_model/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "citizen_budget_model"
  s.version     = CitizenBudgetModel::VERSION
  s.authors     = ["Open North"]
  s.email       = ["info@opennorth.ca"]
  s.homepage    = "http://github.com/opennorth/citizen_budget_model"
  s.summary     = "The Citizen Budget budget simulation model"

  s.files = Dir["{app,config,lib}/**/*"] + ["LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency 'rails', '~> 4.1.0'
  s.add_dependency 'pg'

  # ActiveRecord
  s.add_dependency 'acts_as_list', '~> 0.4.0'
  s.add_dependency 'paranoia', '~> 2.0.2'

  # Authentication
  s.add_dependency 'devise', '~> 3.2.4'

  # Internationalization
  s.add_dependency 'globalize', '~> 4.0.2'

  s.add_development_dependency 'database_cleaner', '~> 1.2'
  s.add_development_dependency 'factory_girl_rails', '~> 4.1'
  s.add_development_dependency 'guard-brakeman', '~> 0.5'
  s.add_development_dependency 'guard-bundler', '~> 2.0'
  s.add_development_dependency 'guard-rspec', '~> 2.1'
  s.add_development_dependency 'guard-spork', '~> 1.2'
  # https://github.com/guard/guard#os-x
  s.add_development_dependency 'rb-fsevent', '~> 0.9'
  s.add_development_dependency 'rspec-rails', '~> 2.11'
  s.add_development_dependency 'spork-rails', '~> 4.0'
  s.add_development_dependency 'shoulda-matchers'
  s.add_development_dependency 'coveralls'
  s.add_development_dependency 'pry-rails'
end
