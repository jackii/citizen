require 'rails_helper'

module CitizenBudgetModel
  RSpec.describe TranslationsController, type: :controller do

    describe 'GET index' do
      it 'returns http success' do
        get :index
        expect(response).to be_success
      end
    end

    describe 'GET create' do
      it 'returns http success' do
        post :create, {}
        expect(response).to be_success
      end
    end
  end
end
