require 'spec_helper'

module CitizenBudgetModel
  describe SimulatorsController do
    routes { CitizenBudgetModel::Engine.routes }

    let(:valid_attributes) do
      {
        organization_id: 1,
        name: 'Simulator',
      }
    end

    let(:valid_session) do
      {}
    end

    describe 'GET index' do
      it 'assigns all simulators as @simulators' do
        simulator = Simulator.create! valid_attributes
        get :index, {}, valid_session
        assigns(:simulators).should eq([simulator])
      end
    end

    describe 'GET show' do
      it 'assigns the requested simulator as @simulator' do
        simulator = Simulator.create! valid_attributes
        get :show, {:id => simulator.to_param}, valid_session
        assigns(:simulator).should eq(simulator)
      end
    end

    describe 'GET new' do
      it 'assigns a new simulator as @simulator' do
        get :new, {}, valid_session
        assigns(:simulator).should be_a_new(Simulator)
      end
    end

    describe 'GET edit' do
      it 'assigns the requested simulator as @simulator' do
        simulator = Simulator.create! valid_attributes
        get :edit, {:id => simulator.to_param}, valid_session
        assigns(:simulator).should eq(simulator)
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
          assigns(:simulator).should be_a(Simulator)
          assigns(:simulator).should be_persisted
        end

        it 'redirects to the created simulator' do
          post :create, {:simulator => valid_attributes}, valid_session
          response.should redirect_to(Simulator.last)
        end
      end

      describe 'with invalid params' do
        it 'assigns a newly created but unsaved simulator as @simulator' do
          post :create, {:simulator => { 'name' => '' }}, valid_session
          assigns(:simulator).should be_a_new(Simulator)
        end

        it 're-renders the "new" template' do
          post :create, {:simulator => { 'name' => '' }}, valid_session
          response.should render_template('new')
        end
      end
    end

    describe 'PUT update' do
      describe 'with valid params' do
        it 'updates the requested simulator' do
          simulator = Simulator.create! valid_attributes
          Simulator.any_instance.should_receive(:update).with({ 'name' => 'Simulator' })
          put :update, {:id => simulator.to_param, :simulator => { 'name' => 'Simulator' }}, valid_session
        end

        it 'assigns the requested simulator as @simulator' do
          simulator = Simulator.create! valid_attributes
          put :update, {:id => simulator.to_param, :simulator => valid_attributes}, valid_session
          assigns(:simulator).should eq(simulator)
        end

        it 'redirects to the simulator' do
          simulator = Simulator.create! valid_attributes
          put :update, {:id => simulator.to_param, :simulator => valid_attributes}, valid_session
          response.should redirect_to(simulator)
        end
      end

      describe 'with invalid params' do
        it 'assigns the simulator as @simulator' do
          simulator = Simulator.create! valid_attributes
          put :update, {:id => simulator.to_param, :simulator => { 'name' => '' }}, valid_session
          assigns(:simulator).should eq(simulator)
        end

        it 're-renders the "edit" template' do
          simulator = Simulator.create! valid_attributes
          put :update, {:id => simulator.to_param, :simulator => { 'name' => '' }}, valid_session
          response.should render_template('edit')
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
        response.should redirect_to(simulators_url)
      end
    end
  end
end
