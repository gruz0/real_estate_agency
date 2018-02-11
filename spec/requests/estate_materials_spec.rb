require 'rails_helper'

RSpec.describe 'EstateMaterials', type: :request do
  describe 'GET /estate_materials' do
    it 'works! (now write some real specs)' do
      sign_in authenticated_employee

      get estate_materials_path
      expect(response).to have_http_status(200)
    end
  end
end
