require 'rails_helper'

RSpec.describe ApplyAndDestroyCart do
  let(:interactor) { ApplyAndDestroyCart.new cart: cart }
  let(:context) { interactor.context }

  let(:pricings) do
    [
      create(:pricing, price: 50, quantity: 5),
      create(:pricing, price: 200, quantity: 5)
    ]
  end
  let(:cart_items) do
    [
      create(:cart_item, quantity: 2, pricing: pricings[0]),
      create(:cart_item, quantity: 1, pricing: pricings[1])
    ]
  end
  let(:cart) { create :cart, cart_items: cart_items }

  context 'all is well' do
    it 'succeeds' do
      interactor.call
      expect(context).to be_a_success
    end

    it 'destroys the cart' do
      expect(cart).to receive(:destroy!)
      interactor.call
    end

    it 'updates the first product\'s quantities' do
      expect { interactor.call }.to change(pricings[0], :quantity).
        from(5).to(3)
    end
  end

  context 'stuff fails' do
    before do
      allow(cart).to receive(:destroy!).
        and_raise(ActiveRecord::ActiveRecordError)
    end

    before { interactor.call rescue Interactor::Failure }

    it 'fails' do
      expect(context).to_not be_a_success
    end

    it 'sets the correct error message' do
      expect(context.message).to eq('generic.write_failed')
    end

    it 'doesn\'t update the second product\'s quantities' do
      # reload is required here because a transaction rollback only happens
      # on the DB _not_ on AR objects
      expect(pricings[1].reload.quantity).to eq(5)
    end
  end
end
