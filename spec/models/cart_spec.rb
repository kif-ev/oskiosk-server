require 'rails_helper'

RSpec.describe Cart, type: :model do
  let(:cart) { create :cart, cart_items: cart_items }
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

  describe '#total_price' do
    subject { cart.total_price }

    it { should eq(300) }
  end
end
