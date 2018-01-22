require 'rails_helper'

RSpec.describe 'Streets', type: :request do
  describe 'GET /cities/:city_id/streets' do
    it 'works! (now write some real specs)' do
      city = create(:city)

      get city_streets_path(city)
      expect(response).to have_http_status(200)
    end
  end
end
