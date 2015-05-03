require 'rails_helper'

RSpec.describe PayCart do
  describe '#call' do
    let(:interactor) {PayCart.new(cart_id: 1)}
    let(:context) {interactor.context}
    let(:user) {create(:user, balance: 1000)}
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
    let(:cart) {create(:cart, user: user, cart_items: cart_items)}

    before do
      allow(Cart).to receive(:find_by_id).with(1).and_return(cart)
    end

    context 'when everything is swell' do
      it 'succeeds' do
        interactor.call
        expect(context).to be_a_success
      end

      it 'updates the first product\'s quantities' do
        expect {interactor.call}.to change(pricings[0], :quantity).from(5).to(3)
      end
      it 'updates the second product\'s quantities' do
        expect {interactor.call}.to change(pricings[1], :quantity).from(5).to(4)
      end

      it 'debits the user correctly' do
        expect {interactor.call}.to change(user, :balance).from(1000).to(700)
      end

      it 'deletes the cart' do
        expect(cart).to receive(:destroy!)
        interactor.call
      end

      it 'deletes the cart_items' do
        expect {interactor.call}.to change(CartItem, :count).by(-2)
      end

      it 'creates a transaction' do
        expect {interactor.call}.to change(Transaction, :count).by(1)
      end
    end

    context 'when there\'s no cart with that ID' do
      before do
        allow(Cart).to receive(:find_by_id).with(1).
          and_raise(ActiveRecord::RecordNotFound)
      end

      it 'fails' do
        interactor.call
        expect(context).to_not be_a_success
      end

      it 'sets the correct error message' do
        interactor.call
        expect(context.message).to eq('pay_cart.not_found')
      end
    end

    context 'when things go wrong' do
      before do
        allow(cart).to receive(:destroy!).
          and_raise(ActiveRecord::ActiveRecordError)
      end

      it 'fails' do
        interactor.call
        expect(context).to_not be_a_success
      end

      it 'sets the correct error message' do
        interactor.call
        expect(context.message).to eq('pay_cart.write_failed')
      end

      it 'should not create a transaction' do
        expect {interactor.call}.to_not change(Transaction, :count)
      end

      it 'should not delete the cart' do
        expect {interactor.call}.to_not change(Cart, :count)
      end
    end
  end
end
