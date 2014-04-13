begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

APP_RAKEFILE = File.expand_path('../spec/dummy/Rakefile', __FILE__)
load 'rails/tasks/engine.rake'

require 'thor'
helper = Bundler::GemHelper.new
helper.install

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)
task default: :spec

begin
  require 'yard'
  YARD::Rake::YardocTask.new
rescue LoadError
  task :yard do
    abort 'YARD is not available. In order to run yard, you must: gem install yard'
  end
end

# @see https://github.com/ruby-gettext/gettext/blob/master/Rakefile#L85
# @see https://github.com/grosser/gettext_i18n_rails/blob/master/lib/gettext_i18n_rails/tasks.rb#L22
# @see http://lslezak.blogspot.ca/2012/01/switching-from-gettext-to-fastgettext.html
require 'gettext/tools/task'
GetText::Tools::Task.define do |task|
  task.spec = helper.gemspec
  task.xgettext_options.concat(['--add-comments=TRANSLATORS:', '--sort-output', '--no-wrap'])
end
