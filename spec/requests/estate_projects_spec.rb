# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'EstateProjects', type: :request do
  describe 'GET /estate_projects' do
    it 'works! (now write some real specs)' do
      sign_in authenticated_employee

      get estate_projects_path
      expect(response).to have_http_status(:ok)
    end
  end
end
