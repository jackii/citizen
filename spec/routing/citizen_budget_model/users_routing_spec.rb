require 'rails_helper'

module CitizenBudgetModel
  RSpec.describe UsersController, type: :routing do
    describe 'routing' do
      routes { Engine.routes }

      it 'routes to #index' do
        expect(get: '/users').to route_to('citizen_budget_model/users#index')
      end

      it 'routes to #new' do
        expect(get: '/users/new').to route_to('citizen_budget_model/users#new')
      end

      it 'routes to #edit' do
        expect(get: '/users/1/edit').to route_to('citizen_budget_model/users#edit', id: '1')
      end

      it 'routes to #create' do
        expect(post: '/users').to route_to('citizen_budget_model/users#create')
      end

      it 'routes to #update' do
        expect(put: '/users/1').to route_to('citizen_budget_model/users#update', id: '1')
      end
    end
  end
end
