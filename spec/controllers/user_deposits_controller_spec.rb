require 'rails_helper'

RSpec.describe UserDepositsController, type: :controller do
  subject {response}

  let(:token) {double acceptable?: true}
  before {allow(controller).to receive(:doorkeeper_token) {token}}

  describe '#create' do
    before {request.env['CONTENT_TYPE'] = 'application/json'}
    before do
      expect(UserDeposit).to receive(:call).once.
        with(user_id: '1', amount: 1000)
      post :create, JSON.generate(amount: 1000), user_id: '1'
    end

    context 'with valid parameters' do
      it('passes arguments correctly') {}
      it {is_expected.to have_http_status(:success)}
    end
  end
end
