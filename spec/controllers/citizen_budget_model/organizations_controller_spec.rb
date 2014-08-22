require 'rails_helper'

module CitizenBudgetModel
  RSpec.describe OrganizationsController, type: :controller do
    routes { CitizenBudgetModel::Engine.routes }

    describe 'when not signed in' do
      it 'redirects to sign in page' do
        get :index, {}
        expect(response).to redirect_to(new_user_session_path)
        get :new, {}
        expect(response).to redirect_to(new_user_session_path)
        post :create
        expect(response).to redirect_to(new_user_session_path)
        get :show, {id: 1}
        expect(response).to redirect_to(new_user_session_path)
        get :edit, {id: 1}
        expect(response).to redirect_to(new_user_session_path)
        put :update, {id: 1}
        expect(response).to redirect_to(new_user_session_path)
        delete :destroy, {id: 1}
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'when signed in as regular user' do
      before(:each) do
        @request.env['devise.mapping'] = Devise.mappings[:user]
        sign_in CitizenBudgetModel::User.create!(email: 'user@example.com', organization_id: 1)
      end

      it 'returns a forbidden HTTP status' do
        get :index, {}
        expect(response).to have_http_status(:forbidden)
        get :new, {}
        expect(response).to have_http_status(:forbidden)
        post :create
        expect(response).to have_http_status(:forbidden)
        get :show, {id: 1}
        expect(response).to have_http_status(:forbidden)
        get :edit, {id: 1}
        expect(response).to have_http_status(:forbidden)
        put :update, {id: 1}
        expect(response).to have_http_status(:forbidden)
        delete :destroy, {id: 1}
        expect(response).to have_http_status(:forbidden)
      end
    end

    describe 'when signed in as super user' do
      before(:each) do
        @request.env['devise.mapping'] = Devise.mappings[:user]
        sign_in CitizenBudgetModel::User.create!(email: 'user@example.com')
      end

      let(:valid_attributes) do
        {
          name_en_ca: 'Organization',
        }
      end

      let(:invalid_attributes) do
        {
          name_en_ca: '',
        }
      end

      describe 'GET index' do
        it 'assigns all organizations as @organizations' do
          organization = Organization.create! valid_attributes
          get :index, {}
          expect(assigns(:organizations)).to eq([organization])
        end
      end

      describe 'GET show' do
        it 'assigns the requested organization as @organization' do
          organization = Organization.create! valid_attributes
          Simulator.create!(organization_id: organization.id, name_en_ca: 'Simulator')
          get :show, {id: organization.to_param}
          expect(assigns(:organization)).to eq(organization)
        end
      end

      describe 'GET new' do
        it 'assigns a new organization as @organization' do
          get :new, {}
          expect(assigns(:organization)).to be_a_new(Organization)
        end
      end

      describe 'GET edit' do
        it 'assigns the requested organization as @organization' do
          organization = Organization.create! valid_attributes
          get :edit, {id: organization.to_param}
          expect(assigns(:organization)).to eq(organization)
        end
      end

      describe 'POST create' do
        describe 'with valid params' do
          it 'creates a new Organization' do
            expect {
              post :create, {organization: valid_attributes}
            }.to change(Organization, :count).by(1)
            expect(assigns(:organization)).to be_a(Organization)
            expect(assigns(:organization)).to be_persisted
            expect(response).to redirect_to(Organization.last)
          end
        end

        describe 'with invalid params' do
          it 'assigns a newly created but unsaved organization as @organization' do
            post :create, {organization: invalid_attributes}
            expect(assigns(:organization)).to be_a_new(Organization)
            expect(response).to render_template('new')
          end
        end
      end

      describe 'PUT update' do
        describe 'with valid params' do
          let(:new_attributes) do
            {
              name_en_ca: 'Update',
            }
          end

          it 'updates the requested organization' do
            organization = Organization.create! valid_attributes
            put :update, {id: organization.to_param, organization: new_attributes}
            expect(organization.reload.name).to eq('Update')
            expect(assigns(:organization)).to eq(organization)
            expect(response).to redirect_to(organization)
          end
        end

        describe 'with invalid params' do
          it 'assigns the organization as @organization' do
            organization = Organization.create! valid_attributes
            put :update, {id: organization.to_param, organization: invalid_attributes}
            expect(assigns(:organization)).to eq(organization)
            expect(response).to render_template('edit')
          end
        end
      end

      describe 'DELETE destroy' do
        it 'destroys the requested organization' do
          organization = Organization.create! valid_attributes
          expect {
            delete :destroy, {id: organization.to_param}
          }.to change(Organization, :count).by(-1)
          expect(response).to redirect_to(organizations_path)
        end
      end
    end
  end
end
