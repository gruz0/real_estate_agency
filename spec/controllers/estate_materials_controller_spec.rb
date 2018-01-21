require 'rails_helper'

RSpec.describe EstateMaterialsController, type: :controller do
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
      EstateMaterial.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(response).to be_success
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      estate_material = EstateMaterial.create! valid_attributes
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
      estate_material = EstateMaterial.create! valid_attributes
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
        estate_material = EstateMaterial.create! valid_attributes
        put :update, params: { id: estate_material.to_param, estate_material: new_attributes }, session: valid_session
        estate_material.reload

        expect(estate_material.name).to eq(new_attributes[:name])
      end

      it 'redirects to the estate_material' do
        estate_material = EstateMaterial.create! valid_attributes
        put :update, params: { id: estate_material.to_param, estate_material: valid_attributes }, session: valid_session
        expect(response).to redirect_to(estate_material)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'edit' template)" do
        estate_material = EstateMaterial.create! valid_attributes
        put :update, params: { id: estate_material.to_param, estate_material: invalid_attributes }, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested estate_material' do
      estate_material = EstateMaterial.create! valid_attributes
      expect do
        delete :destroy, params: { id: estate_material.to_param }, session: valid_session
      end.to change(EstateMaterial, :count).by(-1)
    end

    it 'redirects to the estate_materials list' do
      estate_material = EstateMaterial.create! valid_attributes
      delete :destroy, params: { id: estate_material.to_param }, session: valid_session
      expect(response).to redirect_to(estate_materials_url)
    end
  end
end
