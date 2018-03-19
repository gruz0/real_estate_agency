require 'rails_helper'

RSpec.describe 'Employees', type: :request do
  describe 'GET /employees' do
    context 'when user is an employee' do
      it 'redirects to root_path' do
        sign_in authenticated_employee

        get employees_path
        expect(response).to have_http_status(:redirect)
      end
    end

    context 'when user is an admin' do
      it 'returns 200 HTTP Status' do
        sign_in authenticated_admin

        get employees_path
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when user is a service_admin' do
      it 'returns 200 HTTP Status' do
        sign_in authenticated_service_admin

        get employees_path
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
