require 'rails_helper'

module CitizenBudgetModel
  RSpec.describe QuestionsController, type: :routing do
    describe 'routing' do
      routes { CitizenBudgetModel::Engine.routes }

      it 'routes to #new' do
        expect(get: '/simulators/3/sections/2/questions/new').to route_to('citizen_budget_model/questions#new', section_id: '2', simulator_id: '3')
      end

      it 'routes to #show' do
        expect(get: '/simulators/3/sections/2/questions/1').to route_to('citizen_budget_model/questions#show', id: '1', section_id: '2', simulator_id: '3')
      end

      it 'routes to #edit' do
        expect(get: '/simulators/3/sections/2/questions/1/edit').to route_to('citizen_budget_model/questions#edit', id: '1', section_id: '2', simulator_id: '3')
      end

      it 'routes to #create' do
        expect(post: '/simulators/3/sections/2/questions').to route_to('citizen_budget_model/questions#create', section_id: '2', simulator_id: '3')
      end

      it 'routes to #update' do
        expect(put: '/simulators/3/sections/2/questions/1').to route_to('citizen_budget_model/questions#update', id: '1', section_id: '2', simulator_id: '3')
      end

      it 'routes to #destroy' do
        expect(delete: '/simulators/3/sections/2/questions/1').to route_to('citizen_budget_model/questions#destroy', id: '1', section_id: '2', simulator_id: '3')
      end
    end
  end
end
