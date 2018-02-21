require 'rails_helper'

RSpec.describe AddressesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/addresses').to route_to('addresses#index')
    end

    it 'routes to #show' do
      expect(get: '/addresses/1').to route_to('addresses#show', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/addresses/1').to route_to('addresses#destroy', id: '1')
    end
  end
end
