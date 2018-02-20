require 'rails_helper'

RSpec.describe AddressesController, type: :controller do
  let(:city) { create(:city) }
  let(:street) { create(:street, city: city) }
  let(:address) { Address.create!(valid_attributes.merge(street: street)) }

  let(:valid_attributes) do
    attributes_for(:address)
  end

  describe 'GET #index' do
    login_employee

    it 'returns a success response' do
      address
      get :index, params: { city_id: city.to_param, street_id: street.to_param }
      expect(response).to be_success
    end
  end

  describe 'GET #show' do
    login_employee

    it 'returns a success response' do
      get :show, params: { city_id: city.to_param, street_id: street.to_param, id: address.to_param }
      expect(response).to be_success
    end

    it 'redirects to index page if record was not found' do
      get :show, params: { city_id: city.to_param, street_id: street.to_param, id: 42 }
      expect(response).to be_redirect
      expect(flash[:alert]).to eq(I18n.t('views.address.flash_messages.address_was_not_found'))
    end
  end

  describe 'DELETE #destroy' do
    login_employee

    context 'with valid params' do
      it 'destroys the requested address' do
        address
        expect do
          delete :destroy, params: { city_id: city.to_param, street_id: street.to_param, id: address.to_param }
        end.to change(Address, :count).by(-1)
      end

      it 'redirects to the cities list' do
        delete :destroy, params: { city_id: city.to_param, street_id: street.to_param, id: address.to_param }
        expect(response).to redirect_to(city_street_addresses_url(city, street))
      end

      it 'renders flash notice' do
        delete :destroy, params: { city_id: city.to_param, street_id: street.to_param, id: address.to_param }
        expect(flash[:notice]).to eq(I18n.t('views.address.flash_messages.address_was_successfully_destroyed'))
      end
    end

    context 'with invalid params' do
      it 'redirects to index page if city was not found' do
        delete :destroy, params: { city_id: 42, street_id: 42, id: 42 }
        expect(response).to be_redirect
        expect(flash[:alert]).to eq(I18n.t('views.city.flash_messages.city_was_not_found'))
      end

      it 'redirects to index page if street was not found' do
        delete :destroy, params: { city_id: city.to_param, street_id: 42, id: 42 }
        expect(response).to be_redirect
        expect(flash[:alert]).to eq(I18n.t('views.street.flash_messages.street_was_not_found'))
      end

      it 'redirects to index page if address was not found' do
        delete :destroy, params: { city_id: city.to_param, street_id: street.to_param, id: 42 }
        expect(response).to be_redirect
        expect(flash[:alert]).to eq(I18n.t('views.address.flash_messages.address_was_not_found'))
      end
    end
  end
end
