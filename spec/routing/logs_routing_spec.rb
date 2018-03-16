require 'rails_helper'

RSpec.describe LogsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/logs').to route_to('logs#index')
    end

    it 'routes to #show' do
      expect(get: '/logs/1').to route_to('logs#show', id: '1')
    end
  end
end
