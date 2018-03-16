require 'rails_helper'

RSpec.describe 'Logs', type: :request do
  describe 'GET /logs' do
    context 'when user is an employee' do
      it 'redirects to root_path' do
        sign_in authenticated_employee

        get logs_path
        expect(response).to have_http_status(:redirect)
      end
    end

    context 'when user is an admin' do
      it 'redirects to root_Path' do
        sign_in authenticated_admin

        get logs_path
        expect(response).to have_http_status(:redirect)
      end
    end

    context 'when user is an service_admin' do
      it 'returns 200 HTTP Status' do
        sign_in authenticated_service_admin

        get logs_path
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
