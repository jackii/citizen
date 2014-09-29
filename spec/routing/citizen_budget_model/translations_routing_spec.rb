require 'rails_helper'

module CitizenBudgetModel
  RSpec.describe TranslationsController, type: :routing do
    describe 'routing' do
      routes { Engine.routes }

      it 'routes to #index' do
        expect(get: '/translations').to route_to('citizen_budget_model/translations#index')
      end

      it 'routes to #create' do
        expect(post: '/translations').to route_to('citizen_budget_model/translations#create')
      end

      it 'routes to #export' do
        expect(get: '/translations/export').to route_to('citizen_budget_model/translations#export')
      end
    end
  end
end
