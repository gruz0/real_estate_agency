require 'rails_helper'

RSpec.describe 'Addresses', type: :request do
  describe 'GET /cities/:city_id/streets/:street_id/addresses' do
    it 'works! (now write some real specs)' do
      sign_in authenticated_employee

      city = create(:city)
      street = create(:street, city: city)

      get city_street_addresses_path(city, street)
      expect(response).to have_http_status(200)
    end
  end
end
