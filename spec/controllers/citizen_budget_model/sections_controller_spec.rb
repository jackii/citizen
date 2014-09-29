require 'rails_helper'

module CitizenBudgetModel
  RSpec.describe SectionsController, type: :controller do
    routes { Engine.routes }

    let(:valid_attributes_for_create) do
      {
        simulator_id: '1',
        title_en_ca: 'Section',
      }
    end

    let(:valid_attributes_for_admin) do
      {
        simulator_id: '2',
        title_en_ca: 'Section',
      }
    end

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
        post :sort, {id: 1, simulator_id: 1}
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'when signed in as super user' do
      pending
    end

    describe 'when signed in as regular user' do
      before(:each) do
        @request.env['devise.mapping'] = Devise.mappings[:user]
        Organization.create!(id: 1, name_en_ca: 'Organization')
        sign_in User.create!(email: 'user@example.com', organization_id: 1)
        @simulator = Simulator.create!(id: 1, name_en_ca: 'Simulator', organization_id: 1)
        simulator = Simulator.create!(id: 2, name_en_ca: 'Other', organization_id: 2)
      end

      let(:valid_attributes) do
        {
          simulator_id: '1',
          title_en_ca: 'Section',
        }
      end

      describe 'GET show' do
        it 'does not assign the unauthorized section as @section' do
          section = Section.create! valid_attributes_for_admin
          expect{get(:show, {id: section.to_param, simulator_id: 2})}.to raise_error(ActiveRecord::RecordNotFound)
        end

        it 'assigns the requested section as @section' do
          section = Section.create! valid_attributes_for_create
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
        it 'does not assign the unauthorized section as @section' do
          section = Section.create! valid_attributes_for_admin
          expect{get(:edit, {id: section.to_param, simulator_id: 2})}.to raise_error(ActiveRecord::RecordNotFound)
        end

        it 'assigns the requested section as @section' do
          section = Section.create! valid_attributes_for_create
          get :edit, {id: section.to_param, simulator_id: 1}
          expect(assigns(:section)).to eq(section)
        end
      end

      describe 'POST create' do
        describe 'with valid params' do
          it 'does not allow any simulator_id' do
            expect {post :create, {section: valid_attributes_for_admin, simulator_id: 2}}.to raise_error(ActiveRecord::RecordNotFound)
          end

          it 'creates a new Section' do
            expect {
              post :create, {section: valid_attributes, simulator_id: 1}
            }.to change(Section, :count).by(1)
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
              title_en_ca: 'Update',
            }
          end

          it 'does not allow any simulator_id' do
            section = Section.create! valid_attributes_for_create
            expect{put :update, {id: section.to_param, section: new_attributes, simulator_id: 2}}.to raise_error(ActiveRecord::RecordNotFound)
          end

          it 'updates the requested section' do
            section = Section.create! valid_attributes_for_create
            put :update, {id: section.to_param, section: new_attributes, simulator_id: 1}
            expect(section.reload.title).to eq('Update')
            expect(assigns(:section)).to eq(section)
            expect(response).to redirect_to([@simulator, section])
          end
        end
      end

      describe 'DELETE destroy' do
        it 'does not destroy the unauthorized section' do
          section = Section.create! valid_attributes_for_admin
          expect{delete :destroy, {id: section.to_param, simulator_id: 2}}.to raise_error(ActiveRecord::RecordNotFound)
        end

        it 'destroys the requested section' do
          section = Section.create! valid_attributes_for_create
          expect {
            delete :destroy, {id: section.to_param, simulator_id: 1}
          }.to change(Section, :count).by(-1)
          expect(response).to redirect_to([@simulator])
        end
      end

      describe 'POST sort' do
        it 'does not sort the unauthorized simulator' do
          section = Section.create! valid_attributes_for_admin
          expect{post :sort, {id: section.to_param, simulator_id: 2}}.to raise_error(ActiveRecord::RecordNotFound)
        end

        it 'sorts the questions in the section' do
          section = Section.create! valid_attributes_for_create
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
