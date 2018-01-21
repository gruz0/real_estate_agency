require 'rails_helper'

RSpec.describe EstateTypesController, type: :controller do
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
      EstateType.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(response).to be_success
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      estate_type = EstateType.create! valid_attributes
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
      estate_type = EstateType.create! valid_attributes
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
        estate_type = EstateType.create! valid_attributes
        put :update, params: { id: estate_type.to_param, estate_type: new_attributes }, session: valid_session
        estate_type.reload

        expect(estate_type.name).to eq(new_attributes[:name])
      end

      it 'redirects to the estate_type' do
        estate_type = EstateType.create! valid_attributes
        put :update, params: { id: estate_type.to_param, estate_type: valid_attributes }, session: valid_session
        expect(response).to redirect_to(estate_type)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'edit' template)" do
        estate_type = EstateType.create! valid_attributes
        put :update, params: { id: estate_type.to_param, estate_type: invalid_attributes }, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested estate_type' do
      estate_type = EstateType.create! valid_attributes
      expect do
        delete :destroy, params: { id: estate_type.to_param }, session: valid_session
      end.to change(EstateType, :count).by(-1)
    end

    it 'redirects to the estate_types list' do
      estate_type = EstateType.create! valid_attributes
      delete :destroy, params: { id: estate_type.to_param }, session: valid_session
      expect(response).to redirect_to(estate_types_url)
    end
  end
end
