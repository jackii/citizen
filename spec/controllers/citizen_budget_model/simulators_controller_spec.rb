require 'rails_helper'

module CitizenBudgetModel
  RSpec.describe SimulatorsController, type: :controller do
    routes { CitizenBudgetModel::Engine.routes }

    let(:valid_attributes_for_create) do
      {
        organization_id: '1',
        name_en_ca: 'Simulator',
      }
    end

    let(:valid_attributes_for_admin) do
      {
        organization_id: '2',
        name_en_ca: 'Simulator',
      }
    end

    let(:new_attributes_for_admin) do
      {
        organization_id: '3',
        name_en_ca: 'Update',
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
        get :show, {id: 1}
        expect(response).to redirect_to(new_user_session_path)
        get :edit, {id: 1}
        expect(response).to redirect_to(new_user_session_path)
        put :update, {id: 1}
        expect(response).to redirect_to(new_user_session_path)
        delete :destroy, {id: 1}
        expect(response).to redirect_to(new_user_session_path)
        post :activate, {id: 1}
        expect(response).to redirect_to(new_user_session_path)
        post :sort, {id: 1}
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'when signed in as super user' do
      before(:each) do
        @request.env['devise.mapping'] = Devise.mappings[:user]
        sign_in CitizenBudgetModel::User.create!(email: 'user@example.com')
      end

      describe 'GET index' do
        it 'assigns all simulators as @simulators' do
          simulators = []
          simulators << Simulator.create!(valid_attributes_for_admin)
          simulators << Simulator.create!(valid_attributes_for_create)
          get :index, {}
          expect(assigns(:simulators)).to eq(simulators)
        end
      end

      describe 'GET show' do
        it 'assigns the requested simulator as @simulator' do
          simulator = Simulator.create! valid_attributes_for_admin
          Section.create!(simulator_id: simulator.id, title_en_ca: 'Section')
          get :show, {id: simulator.to_param}
          expect(assigns(:simulator)).to eq(simulator)
        end
      end

      describe 'GET edit' do
        it 'assigns the requested simulator as @simulator' do
          simulator = Simulator.create! valid_attributes_for_admin
          get :edit, {id: simulator.to_param}
          expect(assigns(:simulator)).to eq(simulator)
        end
      end

      describe 'POST create' do
        it 'allows any organization_id' do
          expect {
            post :create, {simulator: valid_attributes_for_admin}
          }.to change(Simulator, :count).by(1)
          expect(assigns(:simulator)).to be_a(Simulator)
          expect(assigns(:simulator)).to be_persisted
          expect(response).to redirect_to(Simulator.last)

          expect(assigns(:simulator).organization_id).to eq(2)
        end
      end

      describe 'PUT update' do
        it 'allows any organization_id' do
          simulator = Simulator.create! valid_attributes_for_admin
          put :update, {id: simulator.to_param, simulator: new_attributes_for_admin}
          expect(simulator.reload.name).to eq('Update')
          expect(assigns(:simulator)).to eq(simulator)
          expect(response).to redirect_to(simulator)

          expect(simulator.reload.organization_id).to eq(3)
        end
      end

      describe 'DELETE destroy' do
        it 'destroys the requested simulator' do
          simulator = Simulator.create! valid_attributes_for_admin
          expect {
            delete :destroy, {id: simulator.to_param}
          }.to change(Simulator, :count).by(-1)
          expect(response).to redirect_to(simulators_path)
        end
      end

      describe 'POST activate' do
        it 'activates the requested simulator' do
          simulator = Simulator.create! valid_attributes_for_admin
          post :activate, {id: simulator.to_param}
          expect(simulator.reload.active).to eq(true)
          expect(assigns(:simulator)).to eq(simulator)
          expect(response).to redirect_to(simulator)
        end
      end

      describe 'POST sort' do
        it 'sorts the sections in the simulator' do
          simulator = Simulator.create! valid_attributes_for_admin
          sections = 3.times.map do
            Section.create!(simulator_id: simulator.to_param)
          end
          order = sections.map(&:id)

          expect(simulator.sections.map(&:id)).to eq(order)
          post :sort, {id: simulator.to_param, section: order.reverse!}
          expect(simulator.sections.reload.map(&:id)).to eq(order)
        end
      end
    end

    describe 'when signed in as regular user' do
      before(:each) do
        @request.env['devise.mapping'] = Devise.mappings[:user]
        CitizenBudgetModel::Organization.create!(id: 1, name_en_ca: 'Organization')
        sign_in CitizenBudgetModel::User.create!(email: 'user@example.com', organization_id: 1)
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
        it 'assigns all authorized simulators as @simulators' do
          simulator = Simulator.create! valid_attributes_for_admin
          simulator = Simulator.create! valid_attributes_for_create
          get :index, {}
          expect(assigns(:simulators)).to eq([simulator])
        end
      end

      describe 'GET show' do
        it 'does not assign the unauthorized simulator as @simulator' do
          simulator = Simulator.create! valid_attributes_for_admin
          expect{get(:show, {id: simulator.to_param})}.to raise_error(ActiveRecord::RecordNotFound)
        end

        it 'assigns the requested simulator as @simulator' do
          simulator = Simulator.create! valid_attributes_for_create
          Section.create!(simulator_id: simulator.id, title_en_ca: 'Section')
          get :show, {id: simulator.to_param}
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
        it 'does not assign the unauthorized simulator as @simulator' do
          simulator = Simulator.create! valid_attributes_for_admin
          expect{get(:edit, {id: simulator.to_param})}.to raise_error(ActiveRecord::RecordNotFound)
        end

        it 'assigns the requested simulator as @simulator' do
          simulator = Simulator.create! valid_attributes_for_create
          get :edit, {id: simulator.to_param}
          expect(assigns(:simulator)).to eq(simulator)
        end
      end

      describe 'POST create' do
        describe 'with valid params' do
          it 'does not allow any organization_id' do
            expect {
              post :create, {simulator: valid_attributes_for_admin}
            }.to change(Simulator, :count).by(1)
            expect(assigns(:simulator)).to be_a(Simulator)
            expect(assigns(:simulator)).to be_persisted
            expect(response).to redirect_to(Simulator.last)

            expect(assigns(:simulator).organization_id).to eq(1)
          end

          it 'creates a new Simulator' do
            expect {
              post :create, {simulator: valid_attributes}
            }.to change(Simulator, :count).by(1)
            expect(assigns(:simulator)).to be_a(Simulator)
            expect(assigns(:simulator)).to be_persisted
            expect(response).to redirect_to(Simulator.last)
          end
        end

        describe 'with invalid params' do
          it 'assigns a newly created but unsaved simulator as @simulator' do
            post :create, {simulator: invalid_attributes}
            expect(assigns(:simulator)).to be_a_new(Simulator)
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
            simulator = Simulator.create! valid_attributes_for_create
            put :update, {id: simulator.to_param, simulator: new_attributes_for_admin}
            expect(simulator.reload.name).to eq('Update')
            expect(assigns(:simulator)).to eq(simulator)
            expect(response).to redirect_to(simulator)

            expect(simulator.reload.organization_id).to eq(1)
          end

          it 'updates the requested simulator' do
            simulator = Simulator.create! valid_attributes_for_create
            put :update, {id: simulator.to_param, simulator: new_attributes}
            expect(simulator.reload.name).to eq('Update')
            expect(assigns(:simulator)).to eq(simulator)
            expect(response).to redirect_to(simulator)
          end
        end

        describe 'with invalid params' do
          it 'assigns the simulator as @simulator' do
            simulator = Simulator.create! valid_attributes_for_create
            put :update, {id: simulator.to_param, simulator: invalid_attributes}
            expect(assigns(:simulator)).to eq(simulator)
            expect(response).to render_template('edit')
          end
        end
      end

      describe 'DELETE destroy' do
        it 'does not destroy the unauthorized simulator' do
          simulator = Simulator.create! valid_attributes_for_admin
          expect{delete :destroy, {id: simulator.to_param}}.to raise_error(ActiveRecord::RecordNotFound)
        end

        it 'destroys the requested simulator' do
          simulator = Simulator.create! valid_attributes_for_create
          expect {
            delete :destroy, {id: simulator.to_param}
          }.to change(Simulator, :count).by(-1)
          expect(response).to redirect_to(simulators_path)
        end
      end

      describe 'POST activate' do
        it 'does not sort the unauthorized simulator' do
          simulator = Simulator.create! valid_attributes_for_admin
          expect{post :activate, {id: simulator.to_param}}.to raise_error(ActiveRecord::RecordNotFound)
        end

        it 'activates the requested simulator' do
          simulator = Simulator.create! valid_attributes_for_create
          post :activate, {id: simulator.to_param}
          expect(simulator.reload.active).to eq(true)
          expect(assigns(:simulator)).to eq(simulator)
          expect(response).to redirect_to(simulator)
        end
      end

      describe 'POST sort' do
        it 'does not sort the unauthorized simulator' do
          simulator = Simulator.create! valid_attributes_for_admin
          expect{post :sort, {id: simulator.to_param}}.to raise_error(ActiveRecord::RecordNotFound)
        end

        it 'sorts the sections in the simulator' do
          simulator = Simulator.create! valid_attributes_for_create
          sections = 3.times.map do
            Section.create!(simulator_id: simulator.to_param)
          end
          order = sections.map(&:id)

          expect(simulator.sections.map(&:id)).to eq(order)
          post :sort, {id: simulator.to_param, section: order.reverse!}
          expect(simulator.sections.reload.map(&:id)).to eq(order)
        end
      end
    end
  end
end
