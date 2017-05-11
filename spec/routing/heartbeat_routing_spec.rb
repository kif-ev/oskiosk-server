require 'rails_helper'

RSpec.describe HeartbeatController, type: :routing do
  describe 'routing' do
    it 'routes to #check' do
      expect(get: '/heartbeat').to route_to('heartbeat#check')
    end
  end
end
