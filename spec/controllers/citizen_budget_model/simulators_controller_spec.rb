require 'rails_helper'

module CitizenBudgetModel
  RSpec.describe SimulatorsController, type: :controller do
    routes { CitizenBudgetModel::Engine.routes }

    describe 'when not signed in' do
      it 'redirects to sign in page' do
        get :index, {}
        expect(response).to redirect_to(new_user_session_path)
        get :new, {}
        expect(response).to redirect_to(new_user_session_path)
        post :create
        expect(response).to redirect_to(new_user_session_path)
        get :show, {:id => 1}
        expect(response).to redirect_to(new_user_session_path)
        get :edit, {:id => 1}
        expect(response).to redirect_to(new_user_session_path)
        put :update, {:id => 1}
        expect(response).to redirect_to(new_user_session_path)
        delete :destroy, {:id => 1}
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'when signed in as super user' do
      before(:each) do
        @request.env['devise.mapping'] = Devise.mappings[:user]
        sign_in CitizenBudgetModel::User.create!(email: 'user@example.com')
      end

      describe 'POST create' do
        it 'allows any organization_id' do
          post :create, {:simulator => {organization_id: '2', name_en_ca: 'Simulator'}}
          expect(assigns(:simulator).organization_id).to eq(2)
        end
      end

      describe 'PUT update' do
        it 'allows any organization_id' do
          simulator = Simulator.create!({organization_id: '2', name_en_ca: 'Simulator'})
          put :update, {:id => simulator.to_param, :simulator => {organization_id: '3'}}
          expect(simulator.reload.organization_id).to eq(3)
        end
      end      
    end

    describe 'when signed in as regular user' do
      before(:each) do
        @request.env['devise.mapping'] = Devise.mappings[:user]
        sign_in CitizenBudgetModel::User.create!(email: 'user@example.com', organization_id: 1)
      end

      let(:valid_attributes_for_test) do
        {
          organization_id: '1',
          name_en_ca: 'Simulator',
        }
      end

      let(:valid_attributes) do
        {
          name_en_ca: 'Simulator',
        }
      end

      let(:invalid_attributes) do
        {
          name_en_ca: '',
        }
      end

      describe 'GET index' do
        it 'assigns all simulators as @simulators' do
          simulator = Simulator.create! valid_attributes_for_test
          get :index, {}
          expect(assigns(:simulators)).to eq([simulator])
        end
      end

      describe 'GET show' do
        it 'assigns the requested simulator as @simulator' do
          simulator = Simulator.create! valid_attributes_for_test
          get :show, {:id => simulator.to_param}
          expect(assigns(:simulator)).to eq(simulator)
        end
      end

      describe 'GET new' do
        it 'assigns a new simulator as @simulator' do
          get :new, {}
          expect(assigns(:simulator)).to be_a_new(Simulator)
        end
      end

      describe 'GET edit' do
        it 'assigns the requested simulator as @simulator' do
          simulator = Simulator.create! valid_attributes_for_test
          get :edit, {:id => simulator.to_param}
          expect(assigns(:simulator)).to eq(simulator)
        end
      end

      describe 'POST create' do
        describe 'with valid params' do
          it 'does not allow any organization_id' do
            post :create, {:simulator => {organization_id: '2', name_en_ca: 'Simulator'}}
            expect(assigns(:simulator).organization_id).to eq(1)
          end

          it 'creates a new Simulator' do
            expect {
              post :create, {:simulator => valid_attributes}
            }.to change(Simulator, :count).by(1)
          end

          it 'assigns a newly created simulator as @simulator' do
            post :create, {:simulator => valid_attributes}
            expect(assigns(:simulator)).to be_a(Simulator)
            expect(assigns(:simulator)).to be_persisted
          end

          it 'redirects to the created simulator' do
            post :create, {:simulator => valid_attributes}
            expect(response).to redirect_to(Simulator.last)
          end
        end

        describe 'with invalid params' do
          it 'assigns a newly created but unsaved simulator as @simulator' do
            post :create, {:simulator => invalid_attributes}
            expect(assigns(:simulator)).to be_a_new(Simulator)
          end

          it 're-renders the "new" template' do
            post :create, {:simulator => invalid_attributes}
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

          it 'does not allow any organization_id' do
            simulator = Simulator.create!({organization_id: '1', name_en_ca: 'Simulator'})
            put :update, {:id => simulator.to_param, :simulator => {organization_id: '3'}}
            expect(simulator.reload.organization_id).to eq(1)
          end

          it 'updates the requested simulator' do
            simulator = Simulator.create! valid_attributes_for_test
            put :update, {:id => simulator.to_param, :simulator => new_attributes}
            expect(simulator.reload.name).to eq('Update')
          end

          it 'assigns the requested simulator as @simulator' do
            simulator = Simulator.create! valid_attributes_for_test
            put :update, {:id => simulator.to_param, :simulator => valid_attributes}
            expect(assigns(:simulator)).to eq(simulator)
          end

          it 'redirects to the simulator' do
            simulator = Simulator.create! valid_attributes_for_test
            put :update, {:id => simulator.to_param, :simulator => valid_attributes}
            expect(response).to redirect_to(simulator)
          end
        end

        describe 'with invalid params' do
          it 'assigns the simulator as @simulator' do
            simulator = Simulator.create! valid_attributes_for_test
            put :update, {:id => simulator.to_param, :simulator => invalid_attributes}
            expect(assigns(:simulator)).to eq(simulator)
          end

          it 're-renders the "edit" template' do
            simulator = Simulator.create! valid_attributes_for_test
            put :update, {:id => simulator.to_param, :simulator => invalid_attributes}
            expect(response).to render_template('edit')
          end
        end
      end

      describe 'DELETE destroy' do
        it 'destroys the requested simulator' do
          simulator = Simulator.create! valid_attributes_for_test
          expect {
            delete :destroy, {:id => simulator.to_param}
          }.to change(Simulator, :count).by(-1)
        end

        it 'redirects to the simulators list' do
          simulator = Simulator.create! valid_attributes_for_test
          delete :destroy, {:id => simulator.to_param}
          expect(response).to redirect_to(simulators_url)
        end
      end

      describe 'POST sort' do
        it 'sorts the sections in the simulator' do
          simulator = Simulator.create! valid_attributes_for_test
          sections = 3.times.map do
            Section.create!(simulator_id: simulator.to_param)
          end
          order = sections.map(&:id)

          expect(simulator.sections.map(&:id)).to eq(order)
          post :sort, {:id => simulator.to_param, :section => order.reverse!}
          expect(simulator.sections.reload.map(&:id)).to eq(order)
        end
      end
    end
  end
end
