require 'rails_helper'

module CitizenBudgetModel
  RSpec.describe PagesController, type: :controller do
    routes { CitizenBudgetModel::Engine.routes }

    describe 'GET home' do
      it 'returns http success' do
        get 'home'
        expect(response).to be_success
      end
    end
  end
end
