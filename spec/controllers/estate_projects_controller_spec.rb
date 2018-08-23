require 'rails_helper'

RSpec.describe EstateProjectsController, type: :controller do
  let(:estate_project) { EstateProject.create!(valid_attributes) }

  let(:valid_attributes) do
    attributes_for(:estate_project)
  end

  let(:invalid_attributes) do
    {
      name: ''
    }
  end

  describe 'GET #index' do
    login_employee

    it 'returns a success response' do
      estate_project
      get :index, params: {}
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    login_employee

    it 'returns a success response' do
      get :show, params: { id: estate_project.to_param }
      expect(response).to be_successful
    end

    it 'redirects to index page if record was not found' do
      get :show, params: { id: 100_500 }
      expect(response).to be_redirect
      expect(flash[:alert]).to eq(I18n.t('views.estate_project.flash_messages.estate_project_was_not_found'))
    end
  end

  describe 'GET #new' do
    login_employee

    it 'returns a success response' do
      get :new, params: {}
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    login_employee

    it 'returns a success response' do
      get :edit, params: { id: estate_project.to_param }
      expect(response).to be_successful
    end

    it 'redirects to index page if record was not found' do
      get :edit, params: { id: 100_500 }
      expect(response).to be_redirect
      expect(flash[:alert]).to eq(I18n.t('views.estate_project.flash_messages.estate_project_was_not_found'))
    end
  end

  describe 'POST #create' do
    login_employee

    context 'with valid params' do
      it 'creates a new EstateProject' do
        expect do
          post :create, params: { estate_project: valid_attributes }
        end.to change(EstateProject, :count).by(1)
      end

      it 'redirects to the created estate_project' do
        post :create, params: { estate_project: valid_attributes }
        expect(response).to redirect_to(EstateProject.last)
      end

      it 'renders flash notice' do
        post :create, params: { estate_project: valid_attributes }
        expect(flash[:notice])
          .to eq(I18n.t('views.estate_project.flash_messages.estate_project_was_successfully_created'))
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { estate_project: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'PUT #update' do
    login_employee

    context 'with valid params' do
      let(:new_attributes) do
        {
          name: 'Уральский'
        }
      end

      it 'updates the requested estate_project' do
        put :update, params: { id: estate_project.to_param, estate_project: new_attributes }
        estate_project.reload

        expect(estate_project.name).to eq(new_attributes[:name])
      end

      it 'redirects to the estate_project' do
        put :update, params: { id: estate_project.to_param, estate_project: valid_attributes }
        expect(response).to redirect_to(estate_project)
      end

      it 'renders flash notice' do
        put :update, params: { id: estate_project.to_param, estate_project: valid_attributes }
        expect(flash[:notice])
          .to eq(I18n.t('views.estate_project.flash_messages.estate_project_was_successfully_updated'))
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'edit' template)" do
        put :update, params: { id: estate_project.to_param, estate_project: invalid_attributes }
        expect(response).to be_successful
      end

      it 'redirects to index page if record was not found' do
        put :update, params: { id: 100_500, estate_project: invalid_attributes }
        expect(response).to be_redirect
        expect(flash[:alert]).to eq(I18n.t('views.estate_project.flash_messages.estate_project_was_not_found'))
      end
    end
  end

  describe 'DELETE #destroy' do
    login_employee

    context 'with valid params' do
      it 'destroys the requested estate_project' do
        estate_project
        expect do
          delete :destroy, params: { id: estate_project.to_param }
        end.to change(EstateProject, :count).by(-1)
      end

      it 'redirects to the estate_projects list' do
        delete :destroy, params: { id: estate_project.to_param }
        expect(response).to redirect_to(estate_projects_url)
      end

      it 'renders flash notice' do
        delete :destroy, params: { id: estate_project.to_param }
        expect(flash[:notice])
          .to eq(I18n.t('views.estate_project.flash_messages.estate_project_was_successfully_destroyed'))
      end
    end

    context 'with invalid params' do
      it 'redirects to index page if record was not found' do
        delete :destroy, params: { id: 100_500 }
        expect(response).to be_redirect
        expect(flash[:alert]).to eq(I18n.t('views.estate_project.flash_messages.estate_project_was_not_found'))
      end

      it 'redirects to index page if dependent association exists' do
        create(:estate, estate_project: estate_project)

        delete :destroy, params: { id: estate_project.to_param }
        expect(response).to be_redirect
        expect(flash[:alert])
          .to eq(I18n.t('activerecord.errors.messages.restrict_dependent_destroy.has_many', record: :estate))
      end
    end
  end
end
