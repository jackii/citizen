require 'spec_helper'

module CitizenBudgetModel
  describe SectionsController do
    describe 'routing' do
      routes { CitizenBudgetModel::Engine.routes }

      it 'routes to #index' do
        get('/sections').should route_to('citizen_budget_model/sections#index')
      end

      it 'routes to #new' do
        get('/sections/new').should route_to('citizen_budget_model/sections#new')
      end

      it 'routes to #show' do
        get('/sections/1').should route_to('citizen_budget_model/sections#show', :id => '1')
      end

      it 'routes to #edit' do
        get('/sections/1/edit').should route_to('citizen_budget_model/sections#edit', :id => '1')
      end

      it 'routes to #create' do
        post('/sections').should route_to('citizen_budget_model/sections#create')
      end

      it 'routes to #update' do
        put('/sections/1').should route_to('citizen_budget_model/sections#update', :id => '1')
      end

      it 'routes to #destroy' do
        delete('/sections/1').should route_to('citizen_budget_model/sections#destroy', :id => '1')
      end

      it 'routes to #sort' do
        post('/sections/1/sort').should route_to('citizen_budget_model/sections#sort', :id => '1')
      end
    end
  end
end
