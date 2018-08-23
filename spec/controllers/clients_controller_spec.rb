require 'rails_helper'

RSpec.describe ClientsController, type: :controller do
  let(:client) { Client.create! valid_attributes }

  let(:valid_attributes) do
    attributes_for(:client)
  end

  let(:invalid_attributes) do
    {
      full_name: '',
      phone_numbers: ''
    }
  end

  describe 'GET #index' do
    login_employee

    it 'returns a success response' do
      client
      get :index, params: {}
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    login_employee

    it 'returns a success response' do
      get :show, params: { id: client.to_param }
      expect(response).to be_successful
    end

    it 'redirects to index page if record was not found' do
      get :show, params: { id: 100_500 }
      expect(response).to be_redirect
      expect(flash[:alert]).to eq(I18n.t('views.client.flash_messages.client_was_not_found'))
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
      get :edit, params: { id: client.to_param }
      expect(response).to be_successful
    end

    it 'redirects to index page if record was not found' do
      get :edit, params: { id: 100_500 }
      expect(response).to be_redirect
      expect(flash[:alert]).to eq(I18n.t('views.client.flash_messages.client_was_not_found'))
    end
  end

  describe 'POST #create' do
    login_employee

    context 'with valid params' do
      it 'creates a new Client' do
        expect do
          post :create, params: { client: valid_attributes }
        end.to change(Client, :count).by(1)
      end

      it 'redirects to the created client' do
        post :create, params: { client: valid_attributes }
        expect(response).to redirect_to(Client.last)
      end

      it 'renders flash notice' do
        post :create, params: { client: valid_attributes }
        expect(flash[:notice])
          .to eq(I18n.t('views.client.flash_messages.client_was_successfully_created'))
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { client: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'PUT #update' do
    login_employee

    context 'with valid params' do
      let(:new_attributes) do
        {
          full_name: "#{FFaker::NameRU.last_name} #{FFaker::NameRU.first_name}",
          phone_numbers: '+79993334455'
        }
      end

      it 'updates the requested client' do
        put :update, params: { id: client.to_param, client: new_attributes }
        client.reload

        expect(client.full_name).to eq(new_attributes[:full_name])
        expect(client.phone_numbers).to eq(new_attributes[:phone_numbers])
      end

      it 'redirects to the client' do
        put :update, params: { id: client.to_param, client: valid_attributes }
        expect(response).to redirect_to(client)
      end

      it 'renders flash notice' do
        put :update, params: { id: client.to_param, client: valid_attributes }
        expect(flash[:notice])
          .to eq(I18n.t('views.client.flash_messages.client_was_successfully_updated'))
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'edit' template)" do
        put :update, params: { id: client.to_param, client: invalid_attributes }
        expect(response).to be_successful
      end

      it 'redirects to index page if record was not found' do
        put :update, params: { id: 100_500, client: invalid_attributes }
        expect(response).to be_redirect
        expect(flash[:alert]).to eq(I18n.t('views.client.flash_messages.client_was_not_found'))
      end
    end
  end

  describe 'DELETE #destroy' do
    login_employee

    context 'with valid params' do
      it 'destroys the requested client' do
        client
        expect do
          delete :destroy, params: { id: client.to_param }
        end.to change(Client, :count).by(-1)
      end

      it 'redirects to the clients list' do
        delete :destroy, params: { id: client.to_param }
        expect(response).to redirect_to(clients_url)
      end

      it 'renders flash notice' do
        delete :destroy, params: { id: client.to_param }
        expect(flash[:notice])
          .to eq(I18n.t('views.client.flash_messages.client_was_successfully_destroyed'))
      end
    end

    context 'with invalid params' do
      it 'redirects to index page if record was not found' do
        delete :destroy, params: { id: 100_500 }
        expect(response).to be_redirect
        expect(flash[:alert]).to eq(I18n.t('views.client.flash_messages.client_was_not_found'))
      end
    end
  end
end
