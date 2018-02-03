require 'rails_helper'

RSpec.describe ClientsController, type: :controller do
  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ClientsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  let(:client) { Client.create! valid_attributes }

  let(:valid_attributes) do
    attributes_for(:client)
  end

  let(:invalid_attributes) do
    {
      last_name: '',
      first_name: '',
      phone_numbers: ''
    }
  end

  describe 'GET #index' do
    it 'returns a success response' do
      client
      get :index, params: {}, session: valid_session
      expect(response).to be_success
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { id: client.to_param }, session: valid_session
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
      get :edit, params: { id: client.to_param }, session: valid_session
      expect(response).to be_success
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Client' do
        expect do
          post :create, params: { client: valid_attributes }, session: valid_session
        end.to change(Client, :count).by(1)
      end

      it 'redirects to the created client' do
        post :create, params: { client: valid_attributes }, session: valid_session
        expect(response).to redirect_to(Client.last)
      end

      it 'renders flash notice' do
        post :create, params: { client: valid_attributes }, session: valid_session
        expect(flash[:notice])
          .to eq(I18n.t('views.client.flash_messages.client_was_successfully_created'))
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { client: invalid_attributes }, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        {
          last_name: FFaker::NameRU.last_name,
          first_name: FFaker::NameRU.first_name,
          middle_name: FFaker::NameRU.patronymic,
          phone_numbers: FFaker::PhoneNumber.phone_number
        }
      end

      it 'updates the requested client' do
        put :update, params: { id: client.to_param, client: new_attributes }, session: valid_session
        client.reload

        expect(client.last_name).to eq(new_attributes[:last_name])
        expect(client.first_name).to eq(new_attributes[:first_name])
        expect(client.middle_name).to eq(new_attributes[:middle_name])
        expect(client.phone_numbers).to eq(new_attributes[:phone_numbers])
      end

      it 'redirects to the client' do
        put :update, params: { id: client.to_param, client: valid_attributes }, session: valid_session
        expect(response).to redirect_to(client)
      end

      it 'renders flash notice' do
        put :update, params: { id: client.to_param, client: valid_attributes }, session: valid_session
        expect(flash[:notice])
          .to eq(I18n.t('views.client.flash_messages.client_was_successfully_updated'))
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'edit' template)" do
        put :update, params: { id: client.to_param, client: invalid_attributes }, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested client' do
      client
      expect do
        delete :destroy, params: { id: client.to_param }, session: valid_session
      end.to change(Client, :count).by(-1)
    end

    it 'redirects to the clients list' do
      delete :destroy, params: { id: client.to_param }, session: valid_session
      expect(response).to redirect_to(clients_url)
    end

    it 'renders flash notice' do
      delete :destroy, params: { id: client.to_param }, session: valid_session
      expect(flash[:notice])
        .to eq(I18n.t('views.client.flash_messages.client_was_successfully_destroyed'))
    end
  end
end
