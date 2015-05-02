require 'rails_helper'

RSpec.describe UsersController, type: :routing do
  describe 'routing' do
    it 'routes to #show' do
      expect(get: '/users/1').to route_to('users#show', id: '1')
    end

    it 'routes to UserDeposit#create' do
      expect(post: '/users/1/deposit').
        to route_to('user_deposits#create', user_id: '1')
    end
  end
end
