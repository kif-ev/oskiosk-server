require 'rails_helper'

RSpec.describe TransactionsController, type: :routing do
  describe 'routing' do
    it 'routes to #create' do
      expect(post: '/transactions').to_not route_to('transactions#create')
    end

    it 'routes to #show' do
      expect(get: '/transactions/1').to route_to('transactions#show', id: '1')
    end

    it 'routes to #index' do
      expect(get: '/transactions').to route_to('transactions#index')
    end

    it 'routes to #search' do
      expect(post: '/transactions/search').to route_to('transactions#search')
    end
  end
end
