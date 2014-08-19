require 'rails_helper'

module CitizenBudgetModel
  RSpec.describe SimulatorsController, type: :controller do
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in CitizenBudgetModel::User.create!(email: 'user@example.com')
    end

    routes { CitizenBudgetModel::Engine.routes }

    let(:valid_attributes) do
      {
        organization_id: '1',
        name_en_ca: 'Simulator',
      }
    end

    let(:invalid_attributes) do
      {
        organization_id: '',
        name_en_ca: '',
      }
    end

    let(:valid_session) do
      {}
    end

    describe 'GET index' do
      it 'assigns all simulators as @simulators' do
        simulator = Simulator.create! valid_attributes
        get :index, {}, valid_session
        expect(assigns(:simulators)).to eq([simulator])
      end
    end

    describe 'GET show' do
      it 'assigns the requested simulator as @simulator' do
        simulator = Simulator.create! valid_attributes
        get :show, {:id => simulator.to_param}, valid_session
        expect(assigns(:simulator)).to eq(simulator)
      end
    end

    describe 'GET new' do
      it 'assigns a new simulator as @simulator' do
        get :new, {}, valid_session
        expect(assigns(:simulator)).to be_a_new(Simulator)
      end
    end

    describe 'GET edit' do
      it 'assigns the requested simulator as @simulator' do
        simulator = Simulator.create! valid_attributes
        get :edit, {:id => simulator.to_param}, valid_session
        expect(assigns(:simulator)).to eq(simulator)
      end
    end

    describe 'POST create' do
      describe 'with valid params' do
        it 'creates a new Simulator' do
          expect {
            post :create, {:simulator => valid_attributes}, valid_session
          }.to change(Simulator, :count).by(1)
        end

        it 'assigns a newly created simulator as @simulator' do
          post :create, {:simulator => valid_attributes}, valid_session
          expect(assigns(:simulator)).to be_a(Simulator)
          expect(assigns(:simulator)).to be_persisted
        end

        it 'redirects to the created simulator' do
          post :create, {:simulator => valid_attributes}, valid_session
          expect(response).to redirect_to(Simulator.last)
        end
      end

      describe 'with invalid params' do
        it 'assigns a newly created but unsaved simulator as @simulator' do
          post :create, {:simulator => invalid_attributes}, valid_session
          expect(assigns(:simulator)).to be_a_new(Simulator)
        end

        it 're-renders the "new" template' do
          post :create, {:simulator => invalid_attributes}, valid_session
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

        it 'updates the requested simulator' do
          simulator = Simulator.create! valid_attributes
          put :update, {:id => simulator.to_param, :simulator => new_attributes}, valid_session
          expect(simulator.reload.name).to eq('Update')
        end

        it 'assigns the requested simulator as @simulator' do
          simulator = Simulator.create! valid_attributes
          put :update, {:id => simulator.to_param, :simulator => valid_attributes}, valid_session
          expect(assigns(:simulator)).to eq(simulator)
        end

        it 'redirects to the simulator' do
          simulator = Simulator.create! valid_attributes
          put :update, {:id => simulator.to_param, :simulator => valid_attributes}, valid_session
          expect(response).to redirect_to(simulator)
        end
      end

      describe 'with invalid params' do
        it 'assigns the simulator as @simulator' do
          simulator = Simulator.create! valid_attributes
          put :update, {:id => simulator.to_param, :simulator => invalid_attributes}, valid_session
          expect(assigns(:simulator)).to eq(simulator)
        end

        it 're-renders the "edit" template' do
          simulator = Simulator.create! valid_attributes
          put :update, {:id => simulator.to_param, :simulator => invalid_attributes}, valid_session
          expect(response).to render_template('edit')
        end
      end
    end

    describe 'DELETE destroy' do
      it 'destroys the requested simulator' do
        simulator = Simulator.create! valid_attributes
        expect {
          delete :destroy, {:id => simulator.to_param}, valid_session
        }.to change(Simulator, :count).by(-1)
      end

      it 'redirects to the simulators list' do
        simulator = Simulator.create! valid_attributes
        delete :destroy, {:id => simulator.to_param}, valid_session
        expect(response).to redirect_to(simulators_url)
      end
    end

    describe 'POST sort' do
      it 'sorts the sections in the simulator' do
        simulator = Simulator.create! valid_attributes
        sections = 3.times.map do
          Section.create!(simulator_id: simulator.to_param)
        end
        order = sections.map(&:id)

        expect(simulator.sections.map(&:id)).to eq(order)
        post :sort, {:id => simulator.to_param, :section => order.reverse!}, valid_session
        expect(simulator.sections.reload.map(&:id)).to eq(order)
      end
    end
  end
end
