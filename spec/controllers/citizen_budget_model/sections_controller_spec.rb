require 'spec_helper'

module CitizenBudgetModel
  describe SectionsController do
    routes { CitizenBudgetModel::Engine.routes }

    let(:valid_attributes) do
      {}
    end

    let(:valid_session) do
      {}
    end

    describe 'GET index' do
      it 'assigns all sections as @sections' do
        section = Section.create! valid_attributes
        get :index, {}, valid_session
        assigns(:sections).should eq([section])
      end
    end

    describe 'GET show' do
      it 'assigns the requested section as @section' do
        section = Section.create! valid_attributes
        get :show, {:id => section.to_param}, valid_session
        assigns(:section).should eq(section)
      end
    end

    describe 'GET new' do
      it 'assigns a new section as @section' do
        get :new, {}, valid_session
        assigns(:section).should be_a_new(Section)
      end
    end

    describe 'GET edit' do
      it 'assigns the requested section as @section' do
        section = Section.create! valid_attributes
        get :edit, {:id => section.to_param}, valid_session
        assigns(:section).should eq(section)
      end
    end

    describe 'POST create' do
      describe 'with valid params' do
        it 'creates a new Section' do
          expect {
            post :create, {:section => valid_attributes}, valid_session
          }.to change(Section, :count).by(1)
        end

        it 'assigns a newly created section as @section' do
          post :create, {:section => valid_attributes}, valid_session
          assigns(:section).should be_a(Section)
          assigns(:section).should be_persisted
        end

        it 'redirects to the created section' do
          post :create, {:section => valid_attributes}, valid_session
          response.should redirect_to(Section.last)
        end
      end

      describe 'with invalid params' do
        it 'assigns a newly created but unsaved section as @section' do
          post :create, {:section => { 'simulator_id' => '' }}, valid_session
          assigns(:section).should be_a_new(Section)
        end

        it 're-renders the "new" template' do
          post :create, {:section => { 'simulator_id' => '' }}, valid_session
          response.should render_template('new')
        end
      end
    end

    describe 'PUT update' do
      describe 'with valid params' do
        it 'updates the requested section' do
          section = Section.create! valid_attributes
          Section.any_instance.should_receive(:update).with({ 'simulator_id' => '' })
          put :update, {:id => section.to_param, :section => { 'simulator_id' => '' }}, valid_session
        end

        it 'assigns the requested section as @section' do
          section = Section.create! valid_attributes
          put :update, {:id => section.to_param, :section => valid_attributes}, valid_session
          assigns(:section).should eq(section)
        end

        it 'redirects to the section' do
          section = Section.create! valid_attributes
          put :update, {:id => section.to_param, :section => valid_attributes}, valid_session
          response.should redirect_to(section)
        end
      end

      describe 'with invalid params' do
        it 'assigns the section as @section' do
          section = Section.create! valid_attributes
          put :update, {:id => section.to_param, :section => { 'simulator_id' => '' }}, valid_session
          assigns(:section).should eq(section)
        end

        it 're-renders the "edit" template' do
          section = Section.create! valid_attributes
          put :update, {:id => section.to_param, :section => { 'simulator_id' => '' }}, valid_session
          response.should render_template('edit')
        end
      end
    end

    describe 'DELETE destroy' do
      it 'destroys the requested section' do
        section = Section.create! valid_attributes
        expect {
          delete :destroy, {:id => section.to_param}, valid_session
        }.to change(Section, :count).by(-1)
      end

      it 'redirects to the sections list' do
        section = Section.create! valid_attributes
        delete :destroy, {:id => section.to_param}, valid_session
        response.should redirect_to(sections_url)
      end
    end
  end
end
