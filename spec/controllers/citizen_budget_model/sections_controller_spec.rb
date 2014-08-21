require 'rails_helper'

module CitizenBudgetModel
  RSpec.describe SectionsController, type: :controller do
    routes { CitizenBudgetModel::Engine.routes }

    describe 'when not signed in' do
      it 'redirects to sign in page' do
        get :new, {simulator_id: 1}
        expect(response).to redirect_to(new_user_session_path)
        post :create, {simulator_id: 1}
        expect(response).to redirect_to(new_user_session_path)
        get :show, {id: 1, simulator_id: 1}
        expect(response).to redirect_to(new_user_session_path)
        get :edit, {id: 1, simulator_id: 1}
        expect(response).to redirect_to(new_user_session_path)
        put :update, {id: 1, simulator_id: 1}
        expect(response).to redirect_to(new_user_session_path)
        delete :destroy, {id: 1, simulator_id: 1}
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'when signed in' do
      before(:each) do
        @request.env['devise.mapping'] = Devise.mappings[:user]
        CitizenBudgetModel::Organization.create!(id: 1, name_en_ca: 'Organization')
        @simulator = CitizenBudgetModel::Simulator.create!(id: 1, name_en_ca: 'Simulator', organization_id: 1)
        sign_in CitizenBudgetModel::User.create!(email: 'user@example.com', organization_id: 1)
      end

      let(:valid_attributes) do
        {
          simulator_id: '1',
          title_en_ca: 'Section',
        }
      end

      describe 'GET show' do
        it 'assigns the requested section as @section' do
          section = Section.create! valid_attributes
          get :show, {id: section.to_param, simulator_id: 1}
          expect(assigns(:section)).to eq(section)
        end
      end

      describe 'GET new' do
        it 'assigns a new section as @section' do
          get :new, {simulator_id: 1}
          expect(assigns(:section)).to be_a_new(Section)
        end
      end

      describe 'GET edit' do
        it 'assigns the requested section as @section' do
          section = Section.create! valid_attributes
          get :edit, {id: section.to_param, simulator_id: 1}
          expect(assigns(:section)).to eq(section)
        end
      end

      describe 'POST create' do
        describe 'with valid params' do
          it 'creates a new Section' do
            expect {
              post :create, {section: valid_attributes, simulator_id: 1}
            }.to change(Section, :count).by(1)
            post :create, {section: valid_attributes, simulator_id: 1}
            expect(assigns(:section)).to be_a(Section)
            expect(assigns(:section)).to be_persisted
            expect(response).to redirect_to([@simulator, Section.last])
          end
        end
      end

      describe 'PUT update' do
        describe 'with valid params' do
          let(:new_attributes) do
            {
              simulator_id: '1',
              title_en_ca: 'Update',
            }
          end

          it 'updates the requested section' do
            section = Section.create! valid_attributes
            put :update, {id: section.to_param, section: new_attributes, simulator_id: 1}
            expect(section.reload.title).to eq('Update')
            expect(assigns(:section)).to eq(section)
            expect(response).to redirect_to([@simulator, section])
          end
        end
      end

      describe 'DELETE destroy' do
        it 'destroys the requested section' do
          section = Section.create! valid_attributes
          expect {
            delete :destroy, {id: section.to_param, simulator_id: 1}
          }.to change(Section, :count).by(-1)
          expect(response).to redirect_to([@simulator])
        end
      end

      describe 'POST sort' do
        it 'sorts the questions in the section' do
          section = Section.create! valid_attributes
          questions = 3.times.map do
            Question.create!(section_id: section.to_param)
          end
          order = questions.map(&:id)

          expect(section.questions.map(&:id)).to eq(order)
          post :sort, {id: section.to_param, question: order.reverse!, simulator_id: 1}
          expect(section.questions.reload.map(&:id)).to eq(order)
        end
      end
    end
  end
end
