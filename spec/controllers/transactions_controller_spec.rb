require 'rails_helper'

RSpec.describe TransactionsController, type: :controller do
  subject {response}

  let(:token) {double acceptable?: true}
  before {allow(controller).to receive(:doorkeeper_token) {token}}

  let(:transaction) {Transaction.new}
  let(:context) {double success?: true, transaction: transaction}

  describe '#create' do
    before do
      expect(PayCart).to receive(:call).once.with(cart_id: '1').
        and_return(context)
      post :create, {cart_id: 1}
    end

    context 'with valid parameters' do
      it('passes arguments correctly') {}
      it {is_expected.to have_http_status(:success)}
    end

    context 'with an invalid cart_id' do
      let(:context) {double success?: false, message: 'pay_cart.not_found'}

      it {is_expected.to have_http_status(:not_found)}
    end

    context 'something goes wrong' do
      let(:context) {double success?: false, message: 'pay_cart.write_failed'}

      it {is_expected.to have_http_status(:error)}
    end
  end
end
