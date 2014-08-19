require 'rails_helper'

module CitizenBudgetModel
  RSpec.describe SectionsController, type: :routing do
    describe 'routing' do
      routes { CitizenBudgetModel::Engine.routes }

      it 'routes to #index' do
        expect(get: '/sections').to route_to('citizen_budget_model/sections#index')
      end

      it 'routes to #new' do
        expect(get: '/sections/new').to route_to('citizen_budget_model/sections#new')
      end

      it 'routes to #show' do
        expect(get: '/sections/1').to route_to('citizen_budget_model/sections#show', :id => '1')
      end

      it 'routes to #edit' do
        expect(get: '/sections/1/edit').to route_to('citizen_budget_model/sections#edit', :id => '1')
      end

      it 'routes to #create' do
        expect(post: '/sections').to route_to('citizen_budget_model/sections#create')
      end

      it 'routes to #update' do
        expect(put: '/sections/1').to route_to('citizen_budget_model/sections#update', :id => '1')
      end

      it 'routes to #destroy' do
        expect(delete: '/sections/1').to route_to('citizen_budget_model/sections#destroy', :id => '1')
      end

      it 'routes to #sort' do
        expect(post: '/sections/1/sort').to route_to('citizen_budget_model/sections#sort', :id => '1')
      end
    end
  end
end
