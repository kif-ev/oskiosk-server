require 'rails_helper'

RSpec.describe HeartbeatController, type: :controller do
  subject { response }

  describe '#check' do
    before { get :check }

    it { is_expected.to have_http_status(:ok) }
  end
end
