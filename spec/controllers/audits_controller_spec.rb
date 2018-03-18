require 'rails_helper'

RSpec.describe AuditsController, type: :controller do
  describe 'GET #index' do
    login_service_admin

    it 'returns a success response' do
      get :index, params: {}
      expect(response).to be_success
    end
  end

  describe 'GET #show' do
    login_service_admin

    it 'returns a success response' do
      create(:city)

      get :show, params: { id: Audited::Audit.last.to_param }
      expect(response).to be_success
    end

    it 'redirects to index page if record was not found' do
      get :show, params: { id: 42 }
      expect(response).to be_redirect
      expect(flash[:alert]).to eq(I18n.t('views.audit.flash_messages.audit_was_not_found'))
    end
  end
end
