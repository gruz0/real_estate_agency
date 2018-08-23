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

  describe 'GET #index' do
    login_employee

    it 'returns a success response' do
      city
      get :index, params: {}
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    login_employee

    it 'returns a success response' do
      get :show, params: { id: city.to_param }
      expect(response).to be_successful
    end

    it 'redirects to index page if record was not found' do
      get :show, params: { id: 100_500 }
      expect(response).to be_redirect
      expect(flash[:alert]).to eq(I18n.t('views.city.flash_messages.city_was_not_found'))
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
      get :edit, params: { id: city.to_param }
      expect(response).to be_successful
    end

    it 'redirects to index page if record was not found' do
      get :edit, params: { id: 100_500 }
      expect(response).to be_redirect
      expect(flash[:alert]).to eq(I18n.t('views.city.flash_messages.city_was_not_found'))
    end
  end

  describe 'POST #create' do
    login_employee

    context 'with valid params' do
      it 'creates a new City' do
        expect do
          post :create, params: { city: valid_attributes }
        end.to change(City, :count).by(1)
      end

      it 'redirects to the created city' do
        post :create, params: { city: valid_attributes }
        expect(response).to redirect_to(City.last)
      end

      it 'renders flash notice' do
        post :create, params: { city: valid_attributes }
        expect(flash[:notice]).to eq(I18n.t('views.city.flash_messages.city_was_successfully_created'))
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { city: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'PUT #update' do
    login_employee

    context 'with valid params' do
      let(:new_attributes) do
        {
          name: 'Нефтеюганск'
        }
      end

      it 'updates the requested city' do
        put :update, params: { id: city.to_param, city: new_attributes }
        city.reload

        expect(city.name).to eq(new_attributes[:name])
      end

      it 'redirects to the city' do
        put :update, params: { id: city.to_param, city: valid_attributes }
        expect(response).to redirect_to(city)
      end

      it 'renders flash notice' do
        put :update, params: { id: city.to_param, city: valid_attributes }
        expect(flash[:notice]).to eq(I18n.t('views.city.flash_messages.city_was_successfully_updated'))
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'edit' template)" do
        put :update, params: { id: city.to_param, city: invalid_attributes }
        expect(response).to be_successful
      end

      it 'redirects to index page if record was not found' do
        put :update, params: { id: 100_500, city: invalid_attributes }
        expect(response).to be_redirect
        expect(flash[:alert]).to eq(I18n.t('views.city.flash_messages.city_was_not_found'))
      end
    end
  end

  describe 'DELETE #destroy' do
    login_employee

    context 'with valid params' do
      it 'destroys the requested city' do
        city
        expect do
          delete :destroy, params: { id: city.to_param }
        end.to change(City, :count).by(-1)
      end

      it 'redirects to the cities list' do
        delete :destroy, params: { id: city.to_param }
        expect(response).to redirect_to(cities_url)
      end

      it 'renders flash notice' do
        delete :destroy, params: { id: city.to_param }
        expect(flash[:notice]).to eq(I18n.t('views.city.flash_messages.city_was_successfully_destroyed'))
      end
    end

    context 'with invalid params' do
      it 'redirects to index page if record was not found' do
        delete :destroy, params: { id: 100_500 }
        expect(response).to be_redirect
        expect(flash[:alert]).to eq(I18n.t('views.city.flash_messages.city_was_not_found'))
      end

      it 'redirects to index page if dependent association exists' do
        create(:street, city: city)

        delete :destroy, params: { id: city.to_param }
        expect(response).to be_redirect
        expect(flash[:alert])
          .to eq(I18n.t('activerecord.errors.messages.restrict_dependent_destroy.has_many', record: :street))
      end
    end
  end
end
