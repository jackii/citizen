require 'rails_helper'

module CitizenBudgetModel
  RSpec.describe UsersController, type: :controller do
    routes { CitizenBudgetModel::Engine.routes }

    let(:valid_attributes_for_create) do
      {
        organization_id: '1',
        email: 'friend@example.com',
      }
    end

    let(:valid_attributes_for_admin) do
      {
        organization_id: '2',
        email: 'bob@example.com',
      }
    end

    let(:new_attributes_for_admin) do
      {
        organization_id: '3',
        email: 'foe@example.com',
      }
    end

    describe 'when not signed in' do
      it 'redirects to sign in page' do
        get :index, {}
        expect(response).to redirect_to(new_user_session_path)
        get :new, {}
        expect(response).to redirect_to(new_user_session_path)
        post :create
        expect(response).to redirect_to(new_user_session_path)
        get :edit, {id: 1}
        expect(response).to redirect_to(new_user_session_path)
        put :update, {id: 1}
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'when signed in as super user' do
      before(:each) do
        @request.env['devise.mapping'] = Devise.mappings[:user]
        @user = CitizenBudgetModel::User.create!(email: 'user@example.com')
        sign_in @user
      end

      describe 'GET index' do
        it 'assigns all users as @users' do
          users = []
          users << User.create!(valid_attributes_for_admin)
          users << User.create!(valid_attributes_for_create)
          users << @user
          get :index, {}
          expect(assigns(:users)).to eq(users)
        end
      end

      describe 'GET edit' do
        it 'assigns the requested user as @user' do
          user = User.create! valid_attributes_for_admin
          get :edit, {id: user.to_param}
          expect(assigns(:user)).to eq(user)
        end
      end

      describe 'POST create' do
        it 'allows any organization_id' do
          expect {
            post :create, {user: valid_attributes_for_admin}
          }.to change(User, :count).by(1)
          expect(assigns(:user)).to be_a(User)
          expect(assigns(:user)).to be_persisted
          expect(response).to redirect_to(users_path)

          expect(assigns(:user).organization_id).to eq(2)
        end
      end

      describe 'PUT update' do
        it 'allows any organization_id' do
          user = User.create! valid_attributes_for_admin
          put :update, {id: user.to_param, user: new_attributes_for_admin}
          expect(user.reload.email).to eq('foe@example.com')
          expect(assigns(:user)).to eq(user)
          expect(response).to redirect_to(users_path)

          expect(user.reload.organization_id).to eq(3)
        end
      end
    end

    describe 'when signed in as regular user' do
      before(:each) do
        @request.env['devise.mapping'] = Devise.mappings[:user]
        CitizenBudgetModel::Organization.create!(id: 1, name_en_ca: 'Organization')
        @user = CitizenBudgetModel::User.create!(email: 'user@example.com', organization_id: 1)
        sign_in @user
      end

      let(:valid_attributes) do
        {
          email: 'friend@example.com',
        }
      end

      let(:invalid_attributes) do
        {
          email: '',
        }
      end

      describe 'GET index' do
        it 'assigns all authorized users as @users' do
          user = User.create! valid_attributes_for_admin
          user = User.create! valid_attributes_for_create
          get :index, {}
          expect(assigns(:users)).to eq([user, @user])
        end
      end

      describe 'GET new' do
        it 'assigns a new user as @user' do
          get :new, {}
          expect(assigns(:user)).to be_a_new(User)
        end
      end

      describe 'GET edit' do
        it 'does not assign the unauthorized user as @user' do
          user = User.create! valid_attributes_for_admin
          expect{get(:edit, {id: user.to_param})}.to raise_error(ActiveRecord::RecordNotFound)
        end

        it 'assigns the requested user as @user' do
          user = User.create! valid_attributes_for_create
          get :edit, {id: user.to_param}
          expect(assigns(:user)).to eq(user)
        end
      end

      describe 'POST create' do
        describe 'with valid params' do
          it 'does not allow any organization_id' do
            expect {
              post :create, {user: valid_attributes_for_admin}
            }.to change(User, :count).by(1)
            expect(assigns(:user)).to be_a(User)
            expect(assigns(:user)).to be_persisted
            expect(response).to redirect_to(users_path)

            expect(assigns(:user).organization_id).to eq(1)
          end

          it 'creates a new User' do
            expect {
              post :create, {user: valid_attributes}
            }.to change(User, :count).by(1)
            expect(assigns(:user)).to be_a(User)
            expect(assigns(:user)).to be_persisted
            expect(response).to redirect_to(users_path)
          end
        end

        describe 'with invalid params' do
          it 'assigns a newly created but unsaved user as @user' do
            post :create, {user: invalid_attributes}
            expect(assigns(:user)).to be_a_new(User)
            expect(response).to render_template('new')
          end
        end
      end

      describe 'PUT update' do
        describe 'with valid params' do
          let(:new_attributes) do
            {
              email: 'foe@example.com',
            }
          end

          it 'does not allow any organization_id' do
            user = User.create! valid_attributes_for_create
            put :update, {id: user.to_param, user: new_attributes_for_admin}
            expect(user.reload.email).to eq('foe@example.com')
            expect(assigns(:user)).to eq(user)
            expect(response).to redirect_to(users_path)

            expect(user.reload.organization_id).to eq(1)
          end

          it 'updates the requested user' do
            user = User.create! valid_attributes_for_create
            put :update, {id: user.to_param, user: new_attributes}
            expect(user.reload.email).to eq('foe@example.com')
            expect(assigns(:user)).to eq(user)
            expect(response).to redirect_to(users_path)
          end
        end

        describe 'with invalid params' do
          it 'assigns the user as @user' do
            user = User.create! valid_attributes_for_create
            put :update, {id: user.to_param, user: invalid_attributes}
            expect(assigns(:user)).to eq(user)
            expect(response).to render_template('edit')
          end
        end
      end
    end
  end
end
