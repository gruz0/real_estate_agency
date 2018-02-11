require 'rails_helper'

RSpec.describe 'Estates', type: :request do
  describe 'GET /estates' do
    it 'works! (now write some real specs)' do
      sign_in authenticated_employee

      get estates_path
      expect(response).to have_http_status(200)
    end
  end
end
