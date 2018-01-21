require 'rails_helper'

RSpec.describe EstateTypesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/estate_types').to route_to('estate_types#index')
    end

    it 'routes to #new' do
      expect(get: '/estate_types/new').to route_to('estate_types#new')
    end

    it 'routes to #show' do
      expect(get: '/estate_types/1').to route_to('estate_types#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/estate_types/1/edit').to route_to('estate_types#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/estate_types').to route_to('estate_types#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/estate_types/1').to route_to('estate_types#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/estate_types/1').to route_to('estate_types#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/estate_types/1').to route_to('estate_types#destroy', id: '1')
    end
  end
end