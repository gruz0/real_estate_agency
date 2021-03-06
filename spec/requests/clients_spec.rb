# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Clients', type: :request do
  describe 'GET /clients' do
    it 'works! (now write some real specs)' do
      sign_in authenticated_employee

      get clients_path
      expect(response).to have_http_status(:ok)
    end
  end
end
