require 'spec_helper'

module CitizenBudgetModel
  describe SimulatorsController do
    describe 'routing' do
      routes { CitizenBudgetModel::Engine.routes }

      it 'routes to #index' do
        get('/simulators').should route_to('citizen_budget_model/simulators#index')
      end

      it 'routes to #new' do
        get('/simulators/new').should route_to('citizen_budget_model/simulators#new')
      end

      it 'routes to #show' do
        get('/simulators/1').should route_to('citizen_budget_model/simulators#show', :id => '1')
      end

      it 'routes to #edit' do
        get('/simulators/1/edit').should route_to('citizen_budget_model/simulators#edit', :id => '1')
      end

      it 'routes to #create' do
        post('/simulators').should route_to('citizen_budget_model/simulators#create')
      end

      it 'routes to #update' do
        put('/simulators/1').should route_to('citizen_budget_model/simulators#update', :id => '1')
      end

      it 'routes to #destroy' do
        delete('/simulators/1').should route_to('citizen_budget_model/simulators#destroy', :id => '1')
      end

      it 'routes to #solution' do
        get('/simulators/1/solution').should route_to('citizen_budget_model/simulators#solution', :id => '1')
      end
    end
  end
end
