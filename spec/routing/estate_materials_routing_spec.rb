# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EstateMaterialsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/estate_materials').to route_to('estate_materials#index')
    end

    it 'routes to #new' do
      expect(get: '/estate_materials/new').to route_to('estate_materials#new')
    end

    it 'routes to #show' do
      expect(get: '/estate_materials/1').to route_to('estate_materials#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/estate_materials/1/edit').to route_to('estate_materials#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/estate_materials').to route_to('estate_materials#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/estate_materials/1').to route_to('estate_materials#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/estate_materials/1').to route_to('estate_materials#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/estate_materials/1').to route_to('estate_materials#destroy', id: '1')
    end
  end
end
