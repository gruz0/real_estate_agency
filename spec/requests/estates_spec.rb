require 'rails_helper'

RSpec.describe 'Estates', type: :request do
  let(:estate) { create(:estate) }

  describe 'GET /estates' do
    it 'works! (now write some real specs)' do
      sign_in authenticated_employee

      get estates_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'PATCH /estates/:id/delay' do
    let(:valid_attributes) do
      {
        id: estate.to_param,
        estate: {
          delayed_until: Time.zone.now + 3.days
        }
      }
    end

    before do
      sign_in authenticated_employee
      patch delay_estate_path(estate.to_param), params: valid_attributes
    end

    it 'returns 302 HTTP Status Code' do
      expect(response).to have_http_status(302)
    end

    it 'redirects to estates index page' do
      expect(response).to redirect_to(estate)
    end
  end
end
