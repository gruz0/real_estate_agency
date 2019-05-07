require 'rails_helper'

RSpec.describe 'Streets', type: :request do
  describe 'GET /cities/:city_id/streets' do
    it 'works! (now write some real specs)' do
      sign_in authenticated_employee

      city = create(:city)

      get city_streets_path(city)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /cities/:city_id/streets/search' do
    it 'returns 200 HTTP Status' do
      sign_in authenticated_employee

      city = create(:city)

      get search_city_streets_path(city)
      expect(response).to have_http_status(:ok)
    end
  end
end
