# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CompetitorsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/competitors').to route_to('competitors#index')
    end

    it 'routes to #new' do
      expect(get: '/competitors/new').to route_to('competitors#new')
    end

    it 'routes to #show' do
      expect(get: '/competitors/1').to route_to('competitors#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/competitors/1/edit').to route_to('competitors#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/competitors').to route_to('competitors#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/competitors/1').to route_to('competitors#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/competitors/1').to route_to('competitors#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/competitors/1').to route_to('competitors#destroy', id: '1')
    end
  end
end
