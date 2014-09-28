module CitizenBudgetModel
  class Engine < ::Rails::Engine
    isolate_namespace CitizenBudgetModel

    config.generators do |g|
      g.test_framework :rspec
      g.integration_tool :rspec
    end

    initializer :append_migrations do |app|
      # Unless the application is running within the engine, i.e. the dummy app.
      unless app.root.to_s.match(root.to_s)
        # Paths are an array-like object, so we must use `<<` instead of `+=`.
        config.paths['db/migrate'].expanded.each do |path|
          app.config.paths['db/migrate'] << path
        end
      end
    end
  end
end
