require 'rails_helper'

RSpec.describe StreetsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/cities/3/streets').to route_to('streets#index', city_id: '3')
    end

    it 'routes to #new' do
      expect(get: '/cities/3/streets/new').to route_to('streets#new', city_id: '3')
    end

    it 'routes to #show' do
      expect(get: '/cities/3/streets/1').to route_to('streets#show', city_id: '3', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/cities/3/streets/1/edit').to route_to('streets#edit', city_id: '3', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/cities/3/streets').to route_to('streets#create', city_id: '3')
    end

    it 'routes to #update via PUT' do
      expect(put: '/cities/3/streets/1').to route_to('streets#update', city_id: '3', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/cities/3/streets/1').to route_to('streets#update', city_id: '3', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/cities/3/streets/1').to route_to('streets#destroy', city_id: '3', id: '1')
    end
  end
end
