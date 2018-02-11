require 'rails_helper'

RSpec.describe 'EstateTypes', type: :request do
  describe 'GET /estate_types' do
    it 'works! (now write some real specs)' do
      sign_in authenticated_employee

      get estate_types_path
      expect(response).to have_http_status(200)
    end
  end
end
