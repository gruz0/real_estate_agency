require 'rails_helper'

RSpec.describe EstateTypesController, type: :controller do
  let(:estate_type) { EstateType.create!(valid_attributes) }

  let(:valid_attributes) do
    attributes_for(:estate_type)
  end

  let(:invalid_attributes) do
    {
      name: ''
    }
  end

  describe 'GET #index' do
    login_employee

    it 'returns a success response' do
      estate_type
      get :index, params: {}
      expect(response).to be_success
    end
  end

  describe 'GET #show' do
    login_employee

    it 'returns a success response' do
      get :show, params: { id: estate_type.to_param }
      expect(response).to be_success
    end

    it 'redirects to index page if record was not found' do
      get :show, params: { id: 42 }
      expect(response).to be_redirect
      expect(flash[:alert]).to eq(I18n.t('views.estate_type.flash_messages.estate_type_was_not_found'))
    end
  end

  describe 'GET #new' do
    login_employee

    it 'returns a success response' do
      get :new, params: {}
      expect(response).to be_success
    end
  end

  describe 'GET #edit' do
    login_employee

    it 'returns a success response' do
      get :edit, params: { id: estate_type.to_param }
      expect(response).to be_success
    end

    it 'redirects to index page if record was not found' do
      get :edit, params: { id: 42 }
      expect(response).to be_redirect
      expect(flash[:alert]).to eq(I18n.t('views.estate_type.flash_messages.estate_type_was_not_found'))
    end
  end

  describe 'POST #create' do
    login_employee

    context 'with valid params' do
      it 'creates a new EstateType' do
        expect do
          post :create, params: { estate_type: valid_attributes }
        end.to change(EstateType, :count).by(1)
      end

      it 'redirects to the created estate_type' do
        post :create, params: { estate_type: valid_attributes }
        expect(response).to redirect_to(EstateType.first)
      end

      it 'renders flash notice' do
        post :create, params: { estate_type: valid_attributes }
        expect(flash[:notice])
          .to eq(I18n.t('views.estate_type.flash_messages.estate_type_was_successfully_created'))
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { estate_type: invalid_attributes }
        expect(response).to be_success
      end
    end
  end

  describe 'PUT #update' do
    login_employee

    context 'with valid params' do
      let(:new_attributes) do
        {
          name: 'Дом'
        }
      end

      it 'updates the requested estate_type' do
        put :update, params: { id: estate_type.to_param, estate_type: new_attributes }
        estate_type.reload

        expect(estate_type.name).to eq(new_attributes[:name])
      end

      it 'redirects to the estate_type' do
        put :update, params: { id: estate_type.to_param, estate_type: valid_attributes }
        expect(response).to redirect_to(estate_type)
      end

      it 'renders flash notice' do
        put :update, params: { id: estate_type.to_param, estate_type: valid_attributes }
        expect(flash[:notice])
          .to eq(I18n.t('views.estate_type.flash_messages.estate_type_was_successfully_updated'))
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'edit' template)" do
        put :update, params: { id: estate_type.to_param, estate_type: invalid_attributes }
        expect(response).to be_success
      end

      it 'redirects to index page if record was not found' do
        put :update, params: { id: 42, estate_type: invalid_attributes }
        expect(response).to be_redirect
        expect(flash[:alert]).to eq(I18n.t('views.estate_type.flash_messages.estate_type_was_not_found'))
      end
    end
  end

  describe 'DELETE #destroy' do
    login_employee

    context 'with valid params' do
      it 'destroys the requested estate_type' do
        estate_type
        expect do
          delete :destroy, params: { id: estate_type.to_param }
        end.to change(EstateType, :count).by(-1)
      end

      it 'redirects to the estate_types list' do
        delete :destroy, params: { id: estate_type.to_param }
        expect(response).to redirect_to(estate_types_url)
      end

      it 'renders flash notice' do
        delete :destroy, params: { id: estate_type.to_param }
        expect(flash[:notice])
          .to eq(I18n.t('views.estate_type.flash_messages.estate_type_was_successfully_destroyed'))
      end
    end

    context 'with invalid params' do
      it 'redirects to index page if record was not found' do
        delete :destroy, params: { id: 42 }
        expect(response).to be_redirect
        expect(flash[:alert]).to eq(I18n.t('views.estate_type.flash_messages.estate_type_was_not_found'))
      end

      it 'redirects to index page if dependent association exists' do
        create(:estate, estate_type: estate_type)

        delete :destroy, params: { id: estate_type.to_param }
        expect(response).to be_redirect
        expect(flash[:alert])
          .to eq(I18n.t('activerecord.errors.messages.restrict_dependent_destroy.has_many', record: :estate))
      end
    end
  end
end
