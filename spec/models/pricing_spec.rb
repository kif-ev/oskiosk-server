require 'rails_helper'

RSpec.describe Pricing, type: :model do
  describe '#available_quantity' do
    let(:pricing) {create(:pricing, quantity: 10)}

    subject {pricing.available_quantity}

    context 'there are no currently no blocked items' do
      it {is_expected.to eq 10}
    end

    context 'there are currently blocked items' do
      before {create_list(:cart_item, 2, pricing: pricing, quantity: 2)}
      it {is_expected.to eq 6}
    end
  end
end
