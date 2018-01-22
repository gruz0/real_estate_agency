require 'rails_helper'

RSpec.describe EstateMaterialsController, type: :controller do
  let(:estate_material) { EstateMaterial.create!(valid_attributes) }

  let(:valid_attributes) do
    attributes_for(:estate_material)
  end

  let(:invalid_attributes) do
    {
      name: ''
    }
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # EstateMaterialsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'returns a success response' do
      estate_material
      get :index, params: {}, session: valid_session
      expect(response).to be_success
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { id: estate_material.to_param }, session: valid_session
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
      get :edit, params: { id: estate_material.to_param }, session: valid_session
      expect(response).to be_success
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new EstateMaterial' do
        expect do
          post :create, params: { estate_material: valid_attributes }, session: valid_session
        end.to change(EstateMaterial, :count).by(1)
      end

      it 'redirects to the created estate_material' do
        post :create, params: { estate_material: valid_attributes }, session: valid_session
        expect(response).to redirect_to(EstateMaterial.last)
      end

      it 'renders flash notice' do
        post :create, params: { estate_material: valid_attributes }, session: valid_session
        expect(flash[:notice])
          .to eq(I18n.t('views.estate_material.flash_messages.estate_material_was_successfully_created'))
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { estate_material: invalid_attributes }, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        {
          name: 'Новый материал'
        }
      end

      it 'updates the requested estate_material' do
        put :update, params: { id: estate_material.to_param, estate_material: new_attributes }, session: valid_session
        estate_material.reload

        expect(estate_material.name).to eq(new_attributes[:name])
      end

      it 'redirects to the estate_material' do
        put :update, params: { id: estate_material.to_param, estate_material: valid_attributes }, session: valid_session
        expect(response).to redirect_to(estate_material)
      end

      it 'renders flash notice' do
        put :update, params: { id: estate_material.to_param, estate_material: valid_attributes }, session: valid_session
        expect(flash[:notice])
          .to eq(I18n.t('views.estate_material.flash_messages.estate_material_was_successfully_updated'))
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'edit' template)" do
        put :update, params: { id: estate_material.to_param, estate_material: invalid_attributes }, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested estate_material' do
      estate_material
      expect do
        delete :destroy, params: { id: estate_material.to_param }, session: valid_session
      end.to change(EstateMaterial, :count).by(-1)
    end

    it 'redirects to the estate_materials list' do
      delete :destroy, params: { id: estate_material.to_param }, session: valid_session
      expect(response).to redirect_to(estate_materials_url)
    end

    it 'renders flash notice' do
      delete :destroy, params: { id: estate_material.to_param }, session: valid_session
      expect(flash[:notice])
        .to eq(I18n.t('views.estate_material.flash_messages.estate_material_was_successfully_destroyed'))
    end
  end
end
