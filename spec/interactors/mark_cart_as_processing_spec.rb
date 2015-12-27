require 'rails_helper'

RSpec.describe MarkCartAsProcessing do
  let(:interactor) do
    MarkCartAsProcessing.new cart: cart, cart_version: cart_version
  end
  let(:context) { interactor.context }

  let(:cart) { double }
  let(:cart_version) { 3 }

  context 'when the cart is processing' do
    before do
      allow(cart).to receive(:processing?).and_return(true)
    end

    before { interactor.call rescue Interactor::Failure }

    it 'fails' do
      expect(context).to_not be_a_success
    end

    it 'sets the correct error message' do
      expect(context.message).to eq('generic.processing')
    end
  end

  context 'when the cart is not processing' do
    before do
      allow(cart).to receive(:processing?).and_return(false)
    end

    context 'when the cart is fresh' do
      before do
        allow(cart).to receive(:update).with(
          processing: true,
          lock_version: cart_version
        )
      end

      before { interactor.call }

      it 'succeeds' do
        expect(context).to be_a_success
      end
    end

    context 'when the cart is stale' do
      before do
        allow(cart).to receive(:update).
          and_raise(ActiveRecord::StaleObjectError.new(cart, 'foo'))
      end

      before { interactor.call rescue Interactor::Failure }

      it 'fails' do
        expect(context).to_not be_a_success
      end

      it 'sets the correct error message' do
        expect(context.message).to eq('generic.stale')
      end
    end
  end
end
