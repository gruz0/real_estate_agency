require 'rails_helper'

RSpec.describe EstateProjectsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/estate_projects').to route_to('estate_projects#index')
    end

    it 'routes to #new' do
      expect(get: '/estate_projects/new').to route_to('estate_projects#new')
    end

    it 'routes to #show' do
      expect(get: '/estate_projects/1').to route_to('estate_projects#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/estate_projects/1/edit').to route_to('estate_projects#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/estate_projects').to route_to('estate_projects#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/estate_projects/1').to route_to('estate_projects#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/estate_projects/1').to route_to('estate_projects#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/estate_projects/1').to route_to('estate_projects#destroy', id: '1')
    end
  end
end
