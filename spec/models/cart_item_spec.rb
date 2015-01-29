require 'rails_helper'

RSpec.describe CartItem, type: :model do
  let(:cart_item) {create(:cart_item, pricing: pricing, quantity: quantity)}
  let(:pricing) {}
  let(:quantity) {10}

  describe '#total_price' do
    subject {cart_item.total_price}

    context 'when there is no pricing' do
      it {is_expected.to eq 0}
    end

    context 'when there is a pricing' do
      let(:pricing) {create(:pricing, price: 15)}

      it {is_expected.to eq 150}
    end
  end

  describe '#unit_price' do
    subject {cart_item.unit_price}

    context 'when there is no pricing' do
      it {is_expected.to eq 0}
    end

    context 'when there is a pricing' do
      let(:pricing) {create(:pricing, price: 20)}

      it {is_expected.to eq 20}
    end
  end

  describe '#product_name' do
    subject {cart_item.product_name}

    context 'when there is no product' do
      it {is_expected.to eq ''}
    end

    context 'when there is a product' do
      let(:product) {create(:product, name: 'Turbriskafil')}
      let(:pricing) {product.pricings.first}

      it {is_expected.to eq 'Turbriskafil'}
    end
  end
end
