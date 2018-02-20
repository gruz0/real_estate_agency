require 'rails_helper'

RSpec.describe AddressesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/cities/3/streets/4/addresses').to route_to('addresses#index', city_id: '3', street_id: '4')
    end

    it 'routes to #show' do
      expect(get: '/cities/3/streets/4/addresses/1').to route_to('addresses#show', city_id: '3', street_id: '4', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/cities/3/streets/4/addresses/1').to route_to('addresses#destroy', city_id: '3', street_id: '4', id: '1')
    end
  end
end
