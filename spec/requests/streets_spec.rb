require 'rails_helper'

RSpec.describe 'Streets', type: :request do
  describe 'GET /streets' do
    it 'works! (now write some real specs)' do
      get streets_path
      expect(response).to have_http_status(200)
    end
  end
end
