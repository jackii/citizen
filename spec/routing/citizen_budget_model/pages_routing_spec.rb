require 'rails_helper'

module CitizenBudgetModel
  RSpec.describe PagesController, type: :routing do
    describe 'routing' do
      routes { Engine.routes }

      it 'routes to #home' do
        expect(get: '/').to route_to('citizen_budget_model/pages#home')
      end
    end
  end
end
