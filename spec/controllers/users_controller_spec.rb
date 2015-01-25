require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  subject {response}

  let(:token) {double acceptable?: true}
  before {allow(controller).to receive(:doorkeeper_token) {token}}

  describe '#show' do
    before {User.find_by_id(1) || create(:user, id: 1)}
    before {get :show, id: user_id}

    context 'when the resource exists' do
      let(:user_id) {'1'}
      its(:content_type) {is_expected.to eq 'application/json'}
      it {is_expected.to have_http_status(:ok)}
    end
  end
end
