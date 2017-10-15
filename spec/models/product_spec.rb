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

  describe '#below_warning_threshold?' do
    subject { product.below_warning_threshold? }

    context 'the warning_threshold is not set' do
      before { product.warning_threshold = nil }

      it { is_expected.to be false }
    end

    context 'a warning_threshold is set' do
      context 'and it is less than the remaining items' do
        before { product.warning_threshold = product.quantity - 1 }

        it { is_expected.to be false }
      end

      context 'and it is the same as the remaining items' do
        before { product.warning_threshold = product.quantity }

        it { is_expected.to be true }
      end

      context 'and it is less than the remaining items' do
        before { product.warning_threshold = product.quantity + 5 }

        it { is_expected.to be true }
      end
    end
  end
end
