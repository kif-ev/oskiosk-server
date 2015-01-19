require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:product) {create(:product_without_pricings)}
  describe '#quantity' do
    subject {product.quantity}

    context 'the product has no pricings' do
      it {is_expected.to eq 0}
    end

    context 'the product has some pricings' do
      before {create_list(:pricing, 2, product: product, quantity: 10)}

      it {is_expected.to eq 20}
    end
  end

  describe '#available_quantity' do
    subject {product.available_quantity}

    context 'the product has pricings' do
      before {create_list(:pricing, 2, product: product, quantity: 10)}

      context 'the product is in no cart' do
        it {is_expected.to eq 20}
      end

      context 'the product is in some carts' do
        before do
          create(:cart_item, pricing: product.pricings[0], quantity: 3)
          create(:cart_item, pricing: product.pricings[1], quantity: 2)
        end

        it {is_expected.to eq 15}
      end
    end
  end
end
