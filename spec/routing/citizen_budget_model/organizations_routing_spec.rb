require 'spec_helper'

module CitizenBudgetModel
  describe OrganizationsController do
    describe 'routing' do
      routes { CitizenBudgetModel::Engine.routes }

      it 'routes to #index' do
        get('/organizations').should route_to('citizen_budget_model/organizations#index')
      end

      it 'routes to #new' do
        get('/organizations/new').should route_to('citizen_budget_model/organizations#new')
      end

      it 'routes to #show' do
        get('/organizations/1').should route_to('citizen_budget_model/organizations#show', :id => '1')
      end

      it 'routes to #edit' do
        get('/organizations/1/edit').should route_to('citizen_budget_model/organizations#edit', :id => '1')
      end

      it 'routes to #create' do
        post('/organizations').should route_to('citizen_budget_model/organizations#create')
      end

      it 'routes to #update' do
        put('/organizations/1').should route_to('citizen_budget_model/organizations#update', :id => '1')
      end

      it 'routes to #destroy' do
        delete('/organizations/1').should route_to('citizen_budget_model/organizations#destroy', :id => '1')
      end
    end
  end
end
