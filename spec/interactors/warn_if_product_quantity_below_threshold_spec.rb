require 'rails_helper'

RSpec.describe WarnIfProductQuantityBelowThreshold do
  describe '#call' do
    let(:interactor) { WarnIfProductQuantityBelowThreshold.new cart: cart }
    let(:context) { interactor.context }

    let(:products) do
      [
        create(:product),
        create(:product)
      ]
    end
    let(:cart_items) do
      [
        create(:cart_item, quantity: 2, pricing: products[0].pricings.first),
        create(:cart_item, quantity: 1, pricing: products[1].pricings.first)
      ]
    end
    let(:cart) { create :cart, cart_items: cart_items }

    before do
      allow(AdminMailer).to receive_message_chain(:btp_mail, :deliver_later)
    end
    before { interactor.call }

    context 'when there are no products below their thresholds' do
      it 'succeeds' do
        expect(context).to be_a_success
      end

      it 'doesn\'t send an email' do
        expect(AdminMailer).to_not have_received(:btp_mail)
      end
    end

    context 'when some products are below their threshold' do
      let(:products) do
        [
          create(:product, quantity: 5, warning_threshold: 12),
          create(:product, quantity: 12, warning_threshold: 5),
          create(:product, quantity: 5, warning_threshold: 10)
        ]
      end

      it 'succeeds' do
        expect(context).to be_a_success
      end

      it 'sends an email' do
        expect(AdminMailer).to have_received(:btp_mail).
          with(btp: [products[0]])
      end
    end
  end
end
