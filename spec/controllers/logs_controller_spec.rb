require 'rails_helper'

RSpec.describe LogsController, type: :controller do
  let(:log) { create(:log) }

  describe 'GET #index' do
    login_service_admin

    it 'returns a success response' do
      log
      get :index, params: {}
      expect(response).to be_success
    end
  end

  describe 'GET #show' do
    login_service_admin

    it 'returns a success response' do
      get :show, params: { id: log.to_param }
      expect(response).to be_success
    end

    it 'redirects to index page if record was not found' do
      get :show, params: { id: 42 }
      expect(response).to be_redirect
      expect(flash[:alert]).to eq(I18n.t('views.log.flash_messages.log_was_not_found'))
    end
  end
end
