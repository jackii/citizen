require 'spork'

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'

  require 'coveralls'
  Coveralls.wear!

  require 'rails/application'
  # Prevent Spork from caching the routes.
  Spork.trap_method(Rails::Application::RoutesReloader, :reload!)

  require File.expand_path("../dummy/config/environment.rb",  __FILE__)
  require 'rspec/rails'

  Rails.backtrace_cleaner.remove_silencers!

  Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

  require 'database_cleaner'
  require 'shoulda-matchers'
  require 'factory_girl_rails'

  RSpec.configure do |config|
    # @see https://github.com/plataformatec/devise/wiki/How-To:-Test-controllers-with-Rails-3-and-4-%28and-RSpec%29
    config.include Devise::TestHelpers, type: :controller
    config.extend DeviseHelper, type: :controller

    config.mock_with :rspec

    config.before(:suite) do
      DatabaseCleaner.strategy = :transaction
      DatabaseCleaner.clean_with(:truncation)
    end

    config.before(:each) do
      DatabaseCleaner.start
    end

    config.after(:each) do
      DatabaseCleaner.clean
    end

    # http://railscasts.com/episodes/285-spork
    config.treat_symbols_as_metadata_keys_with_true_values = true
    config.run_all_when_everything_filtered = true
    config.filter_run focus: true

    config.infer_spec_type_from_file_location!
  end
end

Spork.each_run do
  I18n.backend.reload!
  FactoryGirl.reload
end
