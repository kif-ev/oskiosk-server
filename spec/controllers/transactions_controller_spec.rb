require 'rails_helper'

RSpec.describe TransactionsController, type: :controller do
  subject {response}

  describe '#create' do
    before do
      expect(PayCart).to receive(:call).once.with(cart_id: '1')
      post :create, {cart_id: 1}
    end

    context 'with valid parameters' do
      it('passes arguments correctly') {}
      it {is_expected.to have_http_status(:success)}
    end
  end
end
