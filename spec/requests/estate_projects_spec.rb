require 'rails_helper'

RSpec.describe 'EstateProjects', type: :request do
  describe 'GET /estate_projects' do
    it 'works! (now write some real specs)' do
      get estate_projects_path
      expect(response).to have_http_status(200)
    end
  end
end
