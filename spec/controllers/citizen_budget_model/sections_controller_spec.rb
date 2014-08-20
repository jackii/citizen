require 'rails_helper'

module CitizenBudgetModel
  RSpec.describe SectionsController, type: :controller do
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

    describe 'when signed in' do
      before(:each) do
        @request.env['devise.mapping'] = Devise.mappings[:user]
        sign_in CitizenBudgetModel::User.create!(email: 'user@example.com', organization_id: 1)
      end

      let(:valid_attributes) do
        {
          simulator_id: '1',
          title_en_ca: 'Section',
        }
      end

      let(:invalid_attributes) do
        {
          simulator_id: '',
          title_en_ca: '',
        }
      end

      describe 'GET index' do
        it 'assigns all sections as @sections' do
          section = Section.create! valid_attributes
          get :index, {}
          expect(assigns(:sections)).to eq([section])
        end
      end

      describe 'GET show' do
        it 'assigns the requested section as @section' do
          section = Section.create! valid_attributes
          get :show, {:id => section.to_param}
          expect(assigns(:section)).to eq(section)
        end
      end

      describe 'GET new' do
        it 'assigns a new section as @section' do
          get :new, {}
          expect(assigns(:section)).to be_a_new(Section)
        end
      end

      describe 'GET edit' do
        it 'assigns the requested section as @section' do
          section = Section.create! valid_attributes
          get :edit, {:id => section.to_param}
          expect(assigns(:section)).to eq(section)
        end
      end

      describe 'POST create' do
        describe 'with valid params' do
          it 'creates a new Section' do
            expect {
              post :create, {:section => valid_attributes}
            }.to change(Section, :count).by(1)
          end

          it 'assigns a newly created section as @section' do
            post :create, {:section => valid_attributes}
            expect(assigns(:section)).to be_a(Section)
            expect(assigns(:section)).to be_persisted
          end

          it 'redirects to the created section' do
            post :create, {:section => valid_attributes}
            expect(response).to redirect_to(Section.last)
          end
        end

        describe 'with invalid params' do
          it 'assigns a newly created but unsaved section as @section' do
            post :create, {:section => invalid_attributes}
            expect(assigns(:section)).to be_a_new(Section)
          end

          it 're-renders the "new" template' do
            post :create, {:section => invalid_attributes}
            expect(response).to render_template('new')
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
            put :update, {:id => section.to_param, :section => new_attributes}
            expect(section.reload.title).to eq('Update')
          end

          it 'assigns the requested section as @section' do
            section = Section.create! valid_attributes
            put :update, {:id => section.to_param, :section => valid_attributes}
            expect(assigns(:section)).to eq(section)
          end

          it 'redirects to the section' do
            section = Section.create! valid_attributes
            put :update, {:id => section.to_param, :section => valid_attributes}
            expect(response).to redirect_to(section)
          end
        end

        describe 'with invalid params' do
          it 'assigns the section as @section' do
            section = Section.create! valid_attributes
            put :update, {:id => section.to_param, :section => invalid_attributes}
            expect(assigns(:section)).to eq(section)
          end

          it 're-renders the "edit" template' do
            section = Section.create! valid_attributes
            put :update, {:id => section.to_param, :section => invalid_attributes}
            expect(response).to render_template('edit')
          end
        end
      end

      describe 'DELETE destroy' do
        it 'destroys the requested section' do
          section = Section.create! valid_attributes
          expect {
            delete :destroy, {:id => section.to_param}
          }.to change(Section, :count).by(-1)
        end

        it 'redirects to the sections list' do
          section = Section.create! valid_attributes
          delete :destroy, {:id => section.to_param}
          expect(response).to redirect_to(sections_url)
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
          post :sort, {:id => section.to_param, :question => order.reverse!}
          expect(section.questions.reload.map(&:id)).to eq(order)
        end
      end
    end
  end
end
