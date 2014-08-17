require 'spec_helper'

module CitizenBudgetModel
  describe QuestionsController do
    login

    routes { CitizenBudgetModel::Engine.routes }

    let(:valid_attributes) do
      {
        section_id: 1,
      }
    end

    let(:valid_session) do
      {}
    end

    describe 'GET index' do
      it 'assigns all questions as @questions' do
        question = Question.create! valid_attributes
        get :index, {}, valid_session
        assigns(:questions).should eq([question])
      end
    end

    describe 'GET show' do
      it 'assigns the requested question as @question' do
        question = Question.create! valid_attributes
        get :show, {:id => question.to_param}, valid_session
        assigns(:question).should eq(question)
      end
    end

    describe 'GET new' do
      it 'assigns a new question as @question' do
        get :new, {}, valid_session
        assigns(:question).should be_a_new(Question)
      end
    end

    describe 'GET edit' do
      it 'assigns the requested question as @question' do
        question = Question.create! valid_attributes
        get :edit, {:id => question.to_param}, valid_session
        assigns(:question).should eq(question)
      end
    end

    describe 'POST create' do
      describe 'with valid params' do
        it 'creates a new Question' do
          expect {
            post :create, {:question => valid_attributes}, valid_session
          }.to change(Question, :count).by(1)
        end

        it 'assigns a newly created question as @question' do
          post :create, {:question => valid_attributes}, valid_session
          assigns(:question).should be_a(Question)
          assigns(:question).should be_persisted
        end

        it 'redirects to the created question' do
          post :create, {:question => valid_attributes}, valid_session
          response.should redirect_to(Question.last)
        end
      end

      describe 'with invalid params' do
        it 'assigns a newly created but unsaved question as @question' do
          post :create, {:question => { 'section_id' => '' }}, valid_session
          assigns(:question).should be_a_new(Question)
        end

        it 're-renders the "new" template' do
          post :create, {:question => { 'section_id' => '' }}, valid_session
          response.should render_template('new')
        end
      end
    end

    describe 'PUT update' do
      describe 'with valid params' do
        it 'updates the requested question' do
          question = Question.create! valid_attributes
          Question.any_instance.should_receive(:update).with({ 'section_id' => '' })
          put :update, {:id => question.to_param, :question => { 'section_id' => '' }}, valid_session
        end

        it 'assigns the requested question as @question' do
          question = Question.create! valid_attributes
          put :update, {:id => question.to_param, :question => valid_attributes}, valid_session
          assigns(:question).should eq(question)
        end

        it 'redirects to the question' do
          question = Question.create! valid_attributes
          put :update, {:id => question.to_param, :question => valid_attributes}, valid_session
          response.should redirect_to(question)
        end
      end

      describe 'with invalid params' do
        it 'assigns the question as @question' do
          question = Question.create! valid_attributes
          put :update, {:id => question.to_param, :question => { 'section_id' => '' }}, valid_session
          assigns(:question).should eq(question)
        end

        it 're-renders the "edit" template' do
          question = Question.create! valid_attributes
          put :update, {:id => question.to_param, :question => { 'section_id' => '' }}, valid_session
          response.should render_template('edit')
        end
      end
    end

    describe 'DELETE destroy' do
      it 'destroys the requested question' do
        question = Question.create! valid_attributes
        expect {
          delete :destroy, {:id => question.to_param}, valid_session
        }.to change(Question, :count).by(-1)
      end

      it 'redirects to the questions list' do
        question = Question.create! valid_attributes
        delete :destroy, {:id => question.to_param}, valid_session
        response.should redirect_to(questions_url)
      end
    end
  end
end
