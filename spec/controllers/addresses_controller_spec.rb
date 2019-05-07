require 'rails_helper'

RSpec.describe AddressesController, type: :controller do
  let(:city) { create(:city) }
  let(:street) { create(:street, city: city) }
  let(:address) { Address.create!(valid_attributes.merge(street: street)) }

  let(:valid_attributes) do
    attributes_for(:address)
  end

  describe 'GET #index' do
    context 'when user is an employee' do
      login_employee
      include_examples 'addresses controller forbidden index action for non service admin'
    end

    context 'when user is an admin' do
      login_admin
      include_examples 'addresses controller forbidden index action for non service admin'
    end

    context 'when user is a service_admin' do
      login_service_admin

      it 'returns a success response' do
        address
        get :index, params: {}
        expect(response).to be_successful
      end
    end
  end

  describe 'GET #show' do
    context 'when user is an employee' do
      login_employee
      include_examples 'addresses controller forbidden show action for non service admin'
    end

    context 'when user is an admin' do
      login_admin
      include_examples 'addresses controller forbidden show action for non service admin'
    end

    context 'when user is a service_admin' do
      login_service_admin

      it 'returns a success response' do
        get :show, params: { id: address.to_param }
        expect(response).to be_successful
      end

      it 'redirects to index page if record was not found' do
        get :show, params: { id: 100_500 }
        expect(response).to be_redirect
        expect(flash[:alert]).to eq(I18n.t('views.address.flash_messages.address_was_not_found'))
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when user is an employee' do
      login_employee
      include_examples 'addresses controller forbidden destroy action for non service admin'
    end

    context 'when user is an admin' do
      login_admin
      include_examples 'addresses controller forbidden destroy action for non service admin'
    end

    context 'when user is a service_admin' do
      login_service_admin

      context 'with valid params' do
        it 'destroys the requested address' do
          address
          expect do
            delete :destroy, params: { id: address.to_param }
          end.to change(Address, :count).by(-1)
        end

        it 'redirects to the addresses list' do
          delete :destroy, params: { id: address.to_param }
          expect(response).to redirect_to(addresses_url)
        end

        it 'renders flash notice' do
          delete :destroy, params: { id: address.to_param }
          expect(flash[:notice]).to eq(I18n.t('views.address.flash_messages.address_was_successfully_destroyed'))
        end
      end

      context 'with invalid params' do
        it 'redirects to index page if address was not found' do
          delete :destroy, params: { id: 100_500 }
          expect(response).to be_redirect
          expect(flash[:alert]).to eq(I18n.t('views.address.flash_messages.address_was_not_found'))
        end

        it 'redirects to index page if dependent association exists' do
          create(:estate, address: address)

          delete :destroy, params: { id: address.to_param }
          expect(response).to be_redirect
          expect(flash[:alert])
            .to eq(I18n.t('activerecord.errors.messages.restrict_dependent_destroy.has_many', record: :estate))
        end
      end
    end
  end
end
