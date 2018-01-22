require 'rails_helper'

RSpec.describe CitiesController, type: :controller do
  let(:city) { City.create!(valid_attributes) }

  let(:valid_attributes) do
    attributes_for(:city)
  end

  let(:invalid_attributes) do
    {
      name: ''
    }
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # CitiesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'returns a success response' do
      city
      get :index, params: {}, session: valid_session
      expect(response).to be_success
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { id: city.to_param }, session: valid_session
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
      get :edit, params: { id: city.to_param }, session: valid_session
      expect(response).to be_success
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new City' do
        expect do
          post :create, params: { city: valid_attributes }, session: valid_session
        end.to change(City, :count).by(1)
      end

      it 'redirects to the created city' do
        post :create, params: { city: valid_attributes }, session: valid_session
        expect(response).to redirect_to(City.last)
      end

      it 'renders flash notice' do
        post :create, params: { city: valid_attributes }, session: valid_session
        expect(flash[:notice]).to eq(I18n.t('views.city.flash_messages.city_was_successfully_created'))
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { city: invalid_attributes }, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        {
          name: 'Нефтеюганск'
        }
      end

      it 'updates the requested city' do
        put :update, params: { id: city.to_param, city: new_attributes }, session: valid_session
        city.reload

        expect(city.name).to eq(new_attributes[:name])
      end

      it 'redirects to the city' do
        put :update, params: { id: city.to_param, city: valid_attributes }, session: valid_session
        expect(response).to redirect_to(city)
      end

      it 'renders flash notice' do
        put :update, params: { id: city.to_param, city: valid_attributes }, session: valid_session
        expect(flash[:notice]).to eq(I18n.t('views.city.flash_messages.city_was_successfully_updated'))
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'edit' template)" do
        put :update, params: { id: city.to_param, city: invalid_attributes }, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested city' do
      city
      expect do
        delete :destroy, params: { id: city.to_param }, session: valid_session
      end.to change(City, :count).by(-1)
    end

    it 'redirects to the cities list' do
      delete :destroy, params: { id: city.to_param }, session: valid_session
      expect(response).to redirect_to(cities_url)
    end

    it 'renders flash notice' do
      delete :destroy, params: { id: city.to_param }, session: valid_session
      expect(flash[:notice]).to eq(I18n.t('views.city.flash_messages.city_was_successfully_destroyed'))
    end
  end
end
