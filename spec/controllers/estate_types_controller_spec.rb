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

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # EstateTypesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'returns a success response' do
      estate_type
      get :index, params: {}, session: valid_session
      expect(response).to be_success
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { id: estate_type.to_param }, session: valid_session
      expect(response).to be_success
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new, params: {}, session: valid_session
      expect(response).to be_success
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      get :edit, params: { id: estate_type.to_param }, session: valid_session
      expect(response).to be_success
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new EstateType' do
        expect do
          post :create, params: { estate_type: valid_attributes }, session: valid_session
        end.to change(EstateType, :count).by(1)
      end

      it 'redirects to the created estate_type' do
        post :create, params: { estate_type: valid_attributes }, session: valid_session
        expect(response).to redirect_to(EstateType.last)
      end

      it 'renders flash notice' do
        post :create, params: { estate_type: valid_attributes }, session: valid_session
        expect(flash[:notice])
          .to eq(I18n.t('views.estate_type.flash_messages.estate_type_was_successfully_created'))
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { estate_type: invalid_attributes }, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        {
          name: 'Дом'
        }
      end

      it 'updates the requested estate_type' do
        put :update, params: { id: estate_type.to_param, estate_type: new_attributes }, session: valid_session
        estate_type.reload

        expect(estate_type.name).to eq(new_attributes[:name])
      end

      it 'redirects to the estate_type' do
        put :update, params: { id: estate_type.to_param, estate_type: valid_attributes }, session: valid_session
        expect(response).to redirect_to(estate_type)
      end

      it 'renders flash notice' do
        put :update, params: { id: estate_type.to_param, estate_type: valid_attributes }, session: valid_session
        expect(flash[:notice])
          .to eq(I18n.t('views.estate_type.flash_messages.estate_type_was_successfully_updated'))
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'edit' template)" do
        put :update, params: { id: estate_type.to_param, estate_type: invalid_attributes }, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested estate_type' do
      estate_type
      expect do
        delete :destroy, params: { id: estate_type.to_param }, session: valid_session
      end.to change(EstateType, :count).by(-1)
    end

    it 'redirects to the estate_types list' do
      delete :destroy, params: { id: estate_type.to_param }, session: valid_session
      expect(response).to redirect_to(estate_types_url)
    end

    it 'renders flash notice' do
      delete :destroy, params: { id: estate_type.to_param }, session: valid_session
      expect(flash[:notice])
        .to eq(I18n.t('views.estate_type.flash_messages.estate_type_was_successfully_destroyed'))
    end
  end
end
