require 'rails_helper'

RSpec.describe CartPaymentsController, type: :controller do
  subject { response }

  let(:token) { double acceptable?: true, application: application }
  let(:application) { build :doorkeeper_application }
  before { allow(controller).to receive(:doorkeeper_token).and_return(token) }

  let(:transaction) { build :transaction }
  let(:context) { double success?: true, transaction: transaction }

  describe '#create' do
    context 'with valid parameters' do
      before do
        expect(PayCart).to receive(:call).once.
          with(cart_id: '1', requesting_application: application).
          and_return(context)
      end

      before { post :create, cart_id: 1 }

      it('passes arguments correctly') {}
      it { is_expected.to have_http_status(:success) }
    end

    context 'with an invalid cart_id' do
      let(:context) { double success?: false, message: 'generic.not_found' }

      before do
        allow(PayCart).to receive(:call).and_raise(Interactor::Failure).
          and_return(context)
      end

      before { post :create, cart_id: 1 }

      it { is_expected.to have_http_status(:not_found) }
    end

    context 'something goes wrong' do
      let(:context) { double success?: false, message: 'generic.write_failed' }

      before do
        allow(PayCart).to receive(:call).and_raise(Interactor::Failure).
          and_return(context)
      end

      before { post :create, cart_id: 1 }

      it { is_expected.to have_http_status(:error) }
    end
  end
end
