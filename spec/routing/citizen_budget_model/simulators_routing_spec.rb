require 'rails_helper'

module CitizenBudgetModel
  RSpec.describe SimulatorsController, type: :routing do
    describe 'routing' do
      routes { Engine.routes }

      it 'routes to #index' do
        expect(get: '/simulators').to route_to('citizen_budget_model/simulators#index')
      end

      it 'routes to #new' do
        expect(get: '/simulators/new').to route_to('citizen_budget_model/simulators#new')
      end

      it 'routes to #show' do
        expect(get: '/simulators/1').to route_to('citizen_budget_model/simulators#show', id: '1')
      end

      it 'routes to #edit' do
        expect(get: '/simulators/1/edit').to route_to('citizen_budget_model/simulators#edit', id: '1')
      end

      it 'routes to #create' do
        expect(post: '/simulators').to route_to('citizen_budget_model/simulators#create')
      end

      it 'routes to #update' do
        expect(put: '/simulators/1').to route_to('citizen_budget_model/simulators#update', id: '1')
      end

      it 'routes to #destroy' do
        expect(delete: '/simulators/1').to route_to('citizen_budget_model/simulators#destroy', id: '1')
      end

      it 'routes to #activate' do
        expect(post: '/simulators/1/activate').to route_to('citizen_budget_model/simulators#activate', id: '1')
      end

      it 'routes to #sort' do
        expect(post: '/simulators/1/sort').to route_to('citizen_budget_model/simulators#sort', id: '1')
      end
    end
  end
end
