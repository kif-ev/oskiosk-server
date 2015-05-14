require 'rails_helper'

RSpec.describe PopulateCartPaymentTransaction do
  let(:interactor) do
    PopulateCartPaymentTransaction.new transaction: transaction, cart: cart
  end
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
  let(:transaction) { build_stubbed :transaction }

  before { interactor.call }

  it 'succeeds' do
    expect(context).to be_a_success
  end

  it 'sets the transaction type' do
    expect(context.transaction.transaction_type).to eq('cart_payment')
  end

  it 'sets the correct amount' do
    expect(context.transaction.amount).to eq(-300)
  end

  it 'builds transaction_items' do
    expect(context.transaction.transaction_items.length).to eq(2)
  end

  context 'the first transaction_item' do
    subject { context.transaction.transaction_items[0] }

    its(:price) { should eq(50) }
    its(:quantity) { should eq(2) }
  end
end
