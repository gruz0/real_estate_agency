# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Addresses', type: :request do
  describe 'GET /addresses' do
    context 'when user is an employee' do
      it 'redirects to root_path' do
        sign_in authenticated_employee

        get addresses_path
        expect(response).to have_http_status(:redirect)
      end
    end

    context 'when user is an admin' do
      it 'redirects to root_path' do
        sign_in authenticated_admin

        get addresses_path
        expect(response).to have_http_status(:redirect)
      end
    end

    context 'when user is a service_admin' do
      it 'redirects to root_path' do
        sign_in authenticated_service_admin

        get addresses_path
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
