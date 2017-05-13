require 'rails_helper'

RSpec.describe UsersController, type: :routing do
  describe 'routing' do
    it 'routes to #show' do
      expect(get: '/users/1').to route_to('users#show', id: '1')
    end

    it 'routes to #index' do
      expect(get: '/users').to route_to('users#index')
    end

    it 'routes to #create' do
      expect(post: '/users').to route_to('users#create')
    end

    it 'routes to #update' do
      expect(patch: '/users/1').to route_to('users#update', id: '1')
    end

    it 'routes to UserDeposit#create' do
      expect(post: '/users/1/deposit').
        to route_to('user_deposits#create', user_id: '1')
    end
  end
end
