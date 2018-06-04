require 'rails_helper'

RSpec.describe Services::ReassignEstatesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/services/reassign_estates').to route_to('services/reassign_estates#index')
    end

    it 'routes to #update' do
      expect(put: '/services/reassign_estates').to route_to('services/reassign_estates#update')
    end
  end
end
