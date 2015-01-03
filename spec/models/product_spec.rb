require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:product) {create(:product)}
  describe '#quantity' do
    subject {product.quantity}

    context 'the product has no pricings' do
      let(:product) {create(:product_without_pricings)}

      it {is_expected.to eq 0}
    end

    context 'the product has some pricings' do
      let(:product) {create(:product, quantity: 5)}
      before {create_list(:pricing, 2, product: product, quantity: 10)}

      it {is_expected.to eq 25}
    end
  end
end
