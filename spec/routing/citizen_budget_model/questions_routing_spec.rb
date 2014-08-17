require 'spec_helper'

module CitizenBudgetModel
  describe QuestionsController do
    describe 'routing' do
      routes { CitizenBudgetModel::Engine.routes }

      it 'routes to #index' do
        get('/questions').should route_to('citizen_budget_model/questions#index')
      end

      it 'routes to #new' do
        get('/questions/new').should route_to('citizen_budget_model/questions#new')
      end

      it 'routes to #show' do
        get('/questions/1').should route_to('citizen_budget_model/questions#show', :id => '1')
      end

      it 'routes to #edit' do
        get('/questions/1/edit').should route_to('citizen_budget_model/questions#edit', :id => '1')
      end

      it 'routes to #create' do
        post('/questions').should route_to('citizen_budget_model/questions#create')
      end

      it 'routes to #update' do
        put('/questions/1').should route_to('citizen_budget_model/questions#update', :id => '1')
      end

      it 'routes to #destroy' do
        delete('/questions/1').should route_to('citizen_budget_model/questions#destroy', :id => '1')
      end

      it 'routes to #sort' do
        post('/questions/sort').should route_to('citizen_budget_model/questions#sort')
      end
    end
  end
end
