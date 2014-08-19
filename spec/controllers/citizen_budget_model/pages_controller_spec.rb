require 'spec_helper'

module CitizenBudgetModel
  describe PagesController do
    routes { CitizenBudgetModel::Engine.routes }

    describe 'GET home' do
      it 'returns http success' do
        get 'home'
        response.should be_success
      end
    end
  end
end
