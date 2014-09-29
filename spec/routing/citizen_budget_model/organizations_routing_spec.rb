require 'rails_helper'

module CitizenBudgetModel
  RSpec.describe OrganizationsController, type: :routing do
    describe 'routing' do
      routes { Engine.routes }

      it 'routes to #index' do
        expect(get: '/organizations').to route_to('citizen_budget_model/organizations#index')
      end

      it 'routes to #new' do
        expect(get: '/organizations/new').to route_to('citizen_budget_model/organizations#new')
      end

      it 'routes to #show' do
        expect(get: '/organizations/1').to route_to('citizen_budget_model/organizations#show', id: '1')
      end

      it 'routes to #edit' do
        expect(get: '/organizations/1/edit').to route_to('citizen_budget_model/organizations#edit', id: '1')
      end

      it 'routes to #create' do
        expect(post: '/organizations').to route_to('citizen_budget_model/organizations#create')
      end

      it 'routes to #update' do
        expect(put: '/organizations/1').to route_to('citizen_budget_model/organizations#update', id: '1')
      end

      it 'routes to #destroy' do
        expect(delete: '/organizations/1').to route_to('citizen_budget_model/organizations#destroy', id: '1')
      end
    end
  end
end
