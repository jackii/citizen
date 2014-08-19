guard 'bundler' do
  watch('Gemfile')
  watch(/^.+\.gemspec/)
end

guard 'brakeman' do
  watch(%r{^app/.+\.(erb|haml|rhtml|rb)$})
  watch(%r{^config/.+\.rb$})
  watch(%r{^lib/.+\.rb$})
  watch('Gemfile')
end

guard 'spork', rspec_env: { 'RAILS_ENV' => 'test' } do
  watch('Gemfile.lock')
  watch(%r{^config/initializers/.+\.rb$})
  watch(%r{^lib/.+\.rb$})
  watch(%r{^spec/support/.+\.rb$})
  watch(%r{^spec/dummy/.+\.rb$})
  watch('spec/spec_helper.rb')
end

guard 'rspec', cli: '--drb', all_on_start: false, all_after_pass: false do
  watch('Gemfile.lock')                   { "spec" }
  watch(%r{^config/initializers/.+\.rb$}) { "spec" }
  watch(%r{^lib/.+\.rb$})                 { "spec" }
  watch(%r{^spec/support/(.+)\.rb$})      { "spec" }
  watch(%r{^spec/dummy/.+\.rb$})          { "spec" }
  watch('spec/spec_helper.rb')            { "spec" }

  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^app/(.+)\.rb$})                        { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^app/(.*)(\.erb|\.haml)$})              { |m| "spec/#{m[1]}#{m[2]}_spec.rb" }
  watch(%r{^app/controllers/(.+)_controller\.rb$}) { |m| "spec/routing/#{m[1]}_routing_spec.rb" }
  watch('config/routes.rb')                        { "spec/routing" }
  watch('app/controllers/citizen_budget_model_controller.rb') { "spec/controllers" }
end
