require 'rails_helper'

RSpec.describe StreetsController, type: :controller do
  let(:city) { create(:city) }

  let(:valid_attributes) do
    attributes_for(:street).merge(city: city)
  end

  let(:invalid_attributes) do
    {
      city: city,
      name: ''
    }
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # StreetsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'returns a success response' do
      Street.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(response).to be_success
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      street = Street.create! valid_attributes
      get :show, params: { id: street.to_param }, session: valid_session
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
      street = Street.create! valid_attributes
      get :edit, params: { id: street.to_param }, session: valid_session
      expect(response).to be_success
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Street' do
        expect do
          post :create, params: { street: valid_attributes }, session: valid_session
        end.to change(Street, :count).by(1)
      end

      it 'redirects to the created street' do
        post :create, params: { street: valid_attributes }, session: valid_session
        expect(response).to redirect_to(Street.last)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { street: invalid_attributes }, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        {
          city: valid_attributes[:city],
          name: 'ул. Вавилова'
        }
      end

      it 'updates the requested street' do
        street = Street.create! valid_attributes
        put :update, params: { id: street.to_param, street: new_attributes }, session: valid_session
        street.reload

        expect(street.name).to eq(new_attributes[:name])
      end

      it 'redirects to the street' do
        street = Street.create! valid_attributes
        put :update, params: { id: street.to_param, street: valid_attributes }, session: valid_session
        expect(response).to redirect_to(street)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'edit' template)" do
        street = Street.create! valid_attributes
        put :update, params: { id: street.to_param, street: invalid_attributes }, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested street' do
      street = Street.create! valid_attributes
      expect do
        delete :destroy, params: { id: street.to_param }, session: valid_session
      end.to change(Street, :count).by(-1)
    end

    it 'redirects to the streets list' do
      street = Street.create! valid_attributes
      delete :destroy, params: { id: street.to_param }, session: valid_session
      expect(response).to redirect_to(streets_url)
    end
  end
end
