require 'rails_helper'

module CitizenBudgetModel
  RSpec.describe QuestionsController, type: :controller do
    routes { CitizenBudgetModel::Engine.routes }

    describe 'when not signed in' do
      it 'redirects to sign in page' do
        get :new, {simulator_id: 1, section_id: 1}
        expect(response).to redirect_to(new_user_session_path)
        post :create, {simulator_id: 1, section_id: 1}
        expect(response).to redirect_to(new_user_session_path)
        get :show, {id: 1, simulator_id: 1, section_id: 1}
        expect(response).to redirect_to(new_user_session_path)
        get :edit, {id: 1, simulator_id: 1, section_id: 1}
        expect(response).to redirect_to(new_user_session_path)
        put :update, {id: 1, simulator_id: 1, section_id: 1}
        expect(response).to redirect_to(new_user_session_path)
        delete :destroy, {id: 1, simulator_id: 1, section_id: 1}
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'when signed in' do
      before(:each) do
        @request.env['devise.mapping'] = Devise.mappings[:user]
        CitizenBudgetModel::Organization.create!(id: 1, name_en_ca: 'Organization')
        @simulator = CitizenBudgetModel::Simulator.create!(id: 1, name_en_ca: 'Simulator', organization_id: 1)
        @section = CitizenBudgetModel::Section.create!(id: 1, simulator_id: 1)
        sign_in CitizenBudgetModel::User.create!(email: 'user@example.com', organization_id: 1)
      end

      let(:valid_attributes) do
        {
          section_id: '1',
        }
      end

      describe 'GET show' do
        it 'assigns the requested question as @question' do
          question = Question.create! valid_attributes
          get :show, {id: question.to_param, simulator_id: 1, section_id: 1}
          expect(assigns(:question)).to eq(question)
        end
      end

      describe 'GET new' do
        it 'assigns a new question as @question' do
          get :new, {simulator_id: 1, section_id: 1}
          expect(assigns(:question)).to be_a_new(Question)
        end
      end

      describe 'GET edit' do
        it 'assigns the requested question as @question' do
          question = Question.create! valid_attributes
          get :edit, {id: question.to_param, simulator_id: 1, section_id: 1}
          expect(assigns(:question)).to eq(question)
        end
      end

      describe 'POST create' do
        describe 'with valid params' do
          it 'creates a new Question' do
            expect {
              post :create, {question: valid_attributes, simulator_id: 1, section_id: 1}
            }.to change(Question, :count).by(1)
            expect(assigns(:question)).to be_a(Question)
            expect(assigns(:question)).to be_persisted
            expect(response).to redirect_to([@simulator, @section, Question.last])
          end
        end
      end

      describe 'PUT update' do
        describe 'with valid params' do
          let(:new_attributes) do
            {
              title_en_ca: 'Update',
            }
          end

          it 'updates the requested question' do
            question = Question.create! valid_attributes
            put :update, {id: question.to_param, question: new_attributes, simulator_id: 1, section_id: 1}
            expect(question.reload.title).to eq('Update')
            expect(assigns(:question)).to eq(question)
            expect(response).to redirect_to([@simulator, @section, question])
          end
        end
      end

      describe 'DELETE destroy' do
        it 'destroys the requested question' do
          question = Question.create! valid_attributes
          expect {
            delete :destroy, {id: question.to_param, simulator_id: 1, section_id: 1}
          }.to change(Question, :count).by(-1)
          expect(response).to redirect_to([@simulator, @section])
        end
      end
    end
  end
end
