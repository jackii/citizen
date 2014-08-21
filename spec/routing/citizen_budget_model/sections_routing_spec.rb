require 'rails_helper'

module CitizenBudgetModel
  RSpec.describe SectionsController, type: :routing do
    describe 'routing' do
      routes { CitizenBudgetModel::Engine.routes }

      it 'routes to #new' do
        expect(get: '/simulators/2/sections/new').to route_to('citizen_budget_model/sections#new', simulator_id: '2')
      end

      it 'routes to #show' do
        expect(get: '/simulators/2/sections/1').to route_to('citizen_budget_model/sections#show', id: '1', simulator_id: '2')
      end

      it 'routes to #edit' do
        expect(get: '/simulators/2/sections/1/edit').to route_to('citizen_budget_model/sections#edit', id: '1', simulator_id: '2')
      end

      it 'routes to #create' do
        expect(post: '/simulators/2/sections').to route_to('citizen_budget_model/sections#create', simulator_id: '2')
      end

      it 'routes to #update' do
        expect(put: '/simulators/2/sections/1').to route_to('citizen_budget_model/sections#update', id: '1', simulator_id: '2')
      end

      it 'routes to #destroy' do
        expect(delete: '/simulators/2/sections/1').to route_to('citizen_budget_model/sections#destroy', id: '1', simulator_id: '2')
      end

      it 'routes to #sort' do
        expect(post: '/simulators/2/sections/1/sort').to route_to('citizen_budget_model/sections#sort', id: '1', simulator_id: '2')
      end
    end
  end
end
