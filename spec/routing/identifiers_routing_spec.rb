require 'rails_helper'

RSpec.describe IdentifiersController, type: :routing do
  describe 'routing' do
    it 'routes to #show' do
      expect(get: '/identifiers/K00000007').to route_to('identifiers#show', id: 'K00000007')
    end
  end
end
