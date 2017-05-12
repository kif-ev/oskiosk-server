require 'rails_helper'

RSpec.describe ProductsController, type: :routing do
  describe 'routing' do
    it 'routes to #show' do
      expect(get: '/products/P1').to route_to('products#show', id: 'P1')
    end

    it 'routes to #index' do
      expect(get: '/products').to route_to('products#index')
    end

    it 'routes to #create' do
      expect(post: '/products').to route_to('products#create')
    end

    it 'routes to #update' do
      expect(patch: '/products/P1').to route_to('products#update', id: 'P1')
    end
  end
end
