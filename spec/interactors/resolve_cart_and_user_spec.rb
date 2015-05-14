require 'rails_helper'

RSpec.describe ResolveCartAndUser do
  describe '#call' do
    let(:interactor) { ResolveCartAndUser.new(cart_id: 1) }
    let(:context) { interactor.context }

    let(:user) { double }
    let(:cart) { double user: user }

    before do
      allow(Cart).to receive(:find_by_id!).with(1).and_return(cart)
    end

    context 'when the cart exists' do
      before { interactor.call }

      it 'succeeds' do
        expect(context).to be_a_success
      end

      it 'sets the cart in the context' do
        expect(context.cart).to eq(cart)
      end

      it 'sets the user in the context' do
        expect(context.user).to eq(user)
      end
    end

    context 'when the cart doesn\'t exist' do
      before do
        allow(Cart).to receive(:find_by_id!).with(1).
          and_raise(ActiveRecord::RecordNotFound)
      end
      before { interactor.call rescue Interactor::Failure }

      it 'fails' do
        expect(context).to_not be_a_success
      end

      it 'sets the correct error message' do
        expect(context.message).to eq('generic.not_found')
      end
    end

  end
end
