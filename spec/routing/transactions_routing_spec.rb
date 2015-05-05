require 'rails_helper'

RSpec.describe TransactionsController, type: :routing do
  describe 'routing' do
    it 'routes to #create' do
      expect(post: '/transactions').to route_to('transactions#create')
    end

    it 'routes to #index' do
      expect(get: '/transactions').to route_to('transactions#index')
      expect(get: '/transactions/search').to route_to('transactions#index')
      expect(post: '/transactions/search').to route_to('transactions#index')
    end
  end
end
