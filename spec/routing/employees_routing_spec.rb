require 'rails_helper'

RSpec.describe EmployeesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/employees').to route_to('employees#index')
    end

    it 'routes to #new' do
      expect(get: '/employees/new').to route_to('employees#new')
    end

    it 'routes to #show' do
      expect(get: '/employees/1').to route_to('employees#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/employees/1/edit').to route_to('employees#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/employees').to route_to('employees#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/employees/1').to route_to('employees#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/employees/1').to route_to('employees#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/employees/1').to route_to('employees#destroy', id: '1')
    end

    it 'routes to #lock' do
      expect(post: '/employees/1/lock').to route_to('employees#lock', id: '1')
    end

    it 'routes to #unlock' do
      expect(post: '/employees/1/unlock').to route_to('employees#unlock', id: '1')
    end
  end
end
