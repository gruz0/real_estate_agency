# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Cities', type: :request do
  describe 'GET /cities' do
    it 'works! (now write some real specs)' do
      sign_in authenticated_employee

      get cities_path
      expect(response).to have_http_status(:ok)
    end
  end
end
