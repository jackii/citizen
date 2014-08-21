require 'rails_helper'

module CitizenBudgetModel
  RSpec.describe QuestionsController, type: :routing do
    describe 'routing' do
      routes { CitizenBudgetModel::Engine.routes }

      it 'routes to #new' do
        expect(get: '/questions/new').to route_to('citizen_budget_model/questions#new')
      end

      it 'routes to #show' do
        expect(get: '/questions/1').to route_to('citizen_budget_model/questions#show', :id => '1')
      end

      it 'routes to #edit' do
        expect(get: '/questions/1/edit').to route_to('citizen_budget_model/questions#edit', :id => '1')
      end

      it 'routes to #create' do
        expect(post: '/questions').to route_to('citizen_budget_model/questions#create')
      end

      it 'routes to #update' do
        expect(put: '/questions/1').to route_to('citizen_budget_model/questions#update', :id => '1')
      end

      it 'routes to #destroy' do
        expect(delete: '/questions/1').to route_to('citizen_budget_model/questions#destroy', :id => '1')
      end
    end
  end
end
