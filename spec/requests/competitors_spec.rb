require 'rails_helper'

RSpec.describe 'Competitors', type: :request do
  describe 'GET /competitors' do
    it 'works! (now write some real specs)' do
      sign_in authenticated_employee

      get competitors_path
      expect(response).to have_http_status(:ok)
    end
  end
end
