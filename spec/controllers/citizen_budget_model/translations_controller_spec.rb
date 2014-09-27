require 'rails_helper'

module CitizenBudgetModel
  RSpec.describe TranslationsController, type: :controller do
    routes { CitizenBudgetModel::Engine.routes }

    describe 'when not signed in' do
      it 'redirects to sign in page' do
        get :index, {}
        expect(response).to redirect_to(new_user_session_path)
        post :create
        expect(response).to redirect_to(new_user_session_path)
      end

      describe 'GET export' do
        it 'returns translations in the default locale' do
          get :export
          expect(response).to be_success
          expect(JSON.parse(response.body)['']).to eq('lang' => 'en-CA')
        end

        it 'returns translations in the given locale' do
          get :export, locale: 'fr-CA'
          expect(response).to be_success
          expect(JSON.parse(response.body)['']).to eq('lang' => 'fr-CA')
        end
      end
    end

    describe 'when signed in as regular user' do
      before(:each) do
        @request.env['devise.mapping'] = Devise.mappings[:user]
        sign_in CitizenBudgetModel::User.create!(email: 'user@example.com', organization_id: 1)
      end

      describe 'GET index' do
        it 'returns http success' do
          get :index
          expect(response).to be_success
        end
      end

      describe 'GET create' do
        before(:all) do
          I18n.backend.store_translations('en-CA', {'en-CA' => 'en-CA'}, escape: true)
        end

        it 'returns http success' do
          post :create, {pk: 'en-CA.en-CA', value: 'English'}
          expect(response.status).to eq(204)
        end

        it 'fails if parameters are missing' do
          post :create, {pk: 'en-CA.en-CA'}
          expect(response).to be_bad_request
          post :create, {value: 'English'}
          expect(response).to be_bad_request
        end

        it 'fails if key is invalid' do
          post :create, {pk: 'invalid', value: 'English'}
          expect(response).to be_bad_request
        end
      end
    end
  end
end
