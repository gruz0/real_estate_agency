require 'rails_helper'

RSpec.describe StreetsController, type: :controller do
  let(:city) { create(:city) }
  let(:street) { Street.create!(valid_attributes.merge(city: city)) }

  let(:valid_attributes) do
    attributes_for(:street)
  end

  let(:invalid_attributes) do
    {
      name: ''
    }
  end

  describe 'GET #index' do
    login_employee

    it 'returns a success response' do
      street
      get :index, params: { city_id: city.to_param }
      expect(response).to be_success
    end
  end

  describe 'GET #show' do
    login_employee

    it 'returns a success response' do
      get :show, params: { city_id: city.to_param, id: street.to_param }
      expect(response).to be_success
    end

    it 'redirects to index page if city was not found' do
      get :show, params: { city_id: 42, id: 42 }
      expect(response).to be_redirect
      expect(flash[:alert]).to eq(I18n.t('views.city.flash_messages.city_was_not_found'))
    end

    it 'redirects to index page if street was not found' do
      get :show, params: { city_id: city.to_param, id: 42 }
      expect(response).to be_redirect
      expect(flash[:alert]).to eq(I18n.t('views.street.flash_messages.street_was_not_found'))
    end
  end

  describe 'GET #new' do
    login_employee

    it 'returns a success response' do
      get :new, params: { city_id: city.to_param }
      expect(response).to be_success
    end
  end

  describe 'GET #edit' do
    login_employee

    it 'returns a success response' do
      get :edit, params: { city_id: city.to_param, id: street.to_param }
      expect(response).to be_success
    end

    it 'redirects to index page if city was not found' do
      get :edit, params: { city_id: 42, id: 42 }
      expect(response).to be_redirect
      expect(flash[:alert]).to eq(I18n.t('views.city.flash_messages.city_was_not_found'))
    end

    it 'redirects to index page if street was not found' do
      get :edit, params: { city_id: city.to_param, id: 42 }
      expect(response).to be_redirect
      expect(flash[:alert]).to eq(I18n.t('views.street.flash_messages.street_was_not_found'))
    end
  end

  describe 'GET #search' do
    login_employee

    let(:result) do
      street1 = create(:street, city: city, name: 'ул. Главная')
      street2 = create(:street, city: city, name: 'ул. Преображенская')
      street3 = create(:street, city: city, name: '7-й мкрн')

      [
        { id: street3.id, name: street3.name },
        { id: street1.id, name: street1.name },
        { id: street2.id, name: street2.name }
      ]
    end

    it 'returns a success response' do
      get :search, params: { city_id: city.to_param }
      expect(response).to be_success
    end

    it 'returns streets ordered by name as JSON' do
      expected_result = result
      get :search, params: { city_id: city.to_param }

      expect(JSON.parse(response.body, symbolize_names: true)).to eq(expected_result)
    end

    it 'returns streets ordered by name as JSON only for the their city' do
      other_city = create(:city)
      create(:street, city: other_city)

      expected_result = result
      get :search, params: { city_id: city.to_param }

      expect(JSON.parse(response.body, symbolize_names: true)).to eq(expected_result)
    end
  end

  describe 'POST #create' do
    login_employee

    context 'with valid params' do
      it 'creates a new Street' do
        expect do
          post :create, params: { city_id: city.to_param, street: valid_attributes }
        end.to change(Street, :count).by(1)
      end

      it 'redirects to the created street' do
        post :create, params: { city_id: city.to_param, street: valid_attributes }
        expect(response).to redirect_to(city_street_path(city, Street.first))
      end

      it 'renders flash notice' do
        post :create, params: { city_id: city.to_param, street: valid_attributes }
        expect(flash[:notice])
          .to eq(I18n.t('views.street.flash_messages.street_was_successfully_created'))
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { city_id: city.to_param, street: invalid_attributes }
        expect(response).to be_success
      end
    end
  end

  describe 'PUT #update' do
    login_employee

    context 'with valid params' do
      let(:new_attributes) do
        {
          name: 'ул. Вавилова'
        }
      end

      it 'updates the requested street' do
        put :update, params: { city_id: city.to_param, id: street.to_param, street: new_attributes }
        street.reload

        expect(street.name).to eq(new_attributes[:name])
      end

      it 'redirects to the street' do
        put :update, params: { city_id: city.to_param, id: street.to_param, street: valid_attributes }
        expect(response).to redirect_to(city_street_path(city, street))
      end

      it 'renders flash notice' do
        put :update, params: { city_id: city.to_param, id: street.to_param, street: valid_attributes }
        expect(flash[:notice])
          .to eq(I18n.t('views.street.flash_messages.street_was_successfully_updated'))
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'edit' template)" do
        put :update, params: { city_id: city.to_param, id: street.to_param, street: invalid_attributes }
        expect(response).to be_success
      end

      it 'redirects to index page if city was not found' do
        put :update, params: { city_id: 42, id: 42, street: invalid_attributes }
        expect(response).to be_redirect
        expect(flash[:alert]).to eq(I18n.t('views.city.flash_messages.city_was_not_found'))
      end

      it 'redirects to index page if street was not found' do
        put :update, params: { city_id: city.to_param, id: 42, street: invalid_attributes }
        expect(response).to be_redirect
        expect(flash[:alert]).to eq(I18n.t('views.street.flash_messages.street_was_not_found'))
      end

      it 'redirects to #edit page if new name already exists in the current city' do
        street1 = Street.create!(city: city, name: 'ул. Первая')
        street2 = Street.create!(city: city, name: 'ул. Вторая')

        invalid_attributes[:name] = street1.name

        put :update, params: { city_id: city.to_param, id: street2.to_param, street: invalid_attributes }

        expect(response).not_to be_redirect
        expect(flash[:notice]).not_to eq(I18n.t('views.street.flash_messages.street_was_successfully_updated'))
      end
    end
  end

  describe 'DELETE #destroy' do
    login_employee

    context 'with valid params' do
      it 'destroys the requested street' do
        street
        expect do
          delete :destroy, params: { city_id: city.to_param, id: street.to_param }
        end.to change(Street, :count).by(-1)
      end

      it 'redirects to the streets list' do
        delete :destroy, params: { city_id: city.to_param, id: street.to_param }
        expect(response).to redirect_to(city_streets_url(city))
      end

      it 'renders flash notice' do
        delete :destroy, params: { city_id: city.to_param, id: street.to_param }
        expect(flash[:notice])
          .to eq(I18n.t('views.street.flash_messages.street_was_successfully_destroyed'))
      end
    end

    context 'with invalid params' do
      it 'redirects to index page if city was not found' do
        delete :destroy, params: { city_id: 42, id: 42 }
        expect(response).to be_redirect
        expect(flash[:alert]).to eq(I18n.t('views.city.flash_messages.city_was_not_found'))
      end

      it 'redirects to index page if street was not found' do
        delete :destroy, params: { city_id: city.to_param, id: 42 }
        expect(response).to be_redirect
        expect(flash[:alert]).to eq(I18n.t('views.street.flash_messages.street_was_not_found'))
      end

      it 'redirects to index page if dependent association exists' do
        create(:address, street: street)

        delete :destroy, params: { city_id: city.to_param, id: street.to_param }
        expect(response).to be_redirect
        expect(flash[:alert])
          .to eq(I18n.t('activerecord.errors.messages.restrict_dependent_destroy.has_many', record: :address))
      end
    end
  end
end
