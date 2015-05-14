require 'rails_helper'

RSpec.describe ApplyTransactionToUserBalance do
  let(:interactor) do
    ApplyTransactionToUserBalance.new user: user, transaction: transaction
  end
  let(:context) { interactor.context }

  let(:user) { create :user, balance: 1000 }
  let(:transaction) { build_stubbed :transaction, amount: -300 }

  describe '#call' do
    context 'when everything is well' do
      before { interactor.call rescue Interactor::Failure }

      it 'succeeds' do
        expect(context).to be_a_success
      end

      it 'charges the user\'s balance' do
        expect(context.user.balance).to eq(700)
      end

      it 'saves the user' do
        expect(context.user.changed?).to be false
      end
    end

    context 'when stuff breaks' do
      before do
        allow(user).to receive(:save!).
          and_raise(ActiveRecord::ActiveRecordError)
      end

      before { interactor.call rescue Interactor::Failure }

      it 'fails' do
        expect(context).to_not be_a_success
      end

      it 'sets an error message' do
        expect(context.message).to eq('generic.write_failed')
      end
    end
  end

  describe '#rollback' do
    before { interactor.rollback }

    it 'reverts the charge' do
      expect(context.user.balance).to eq(1300)
    end

    it 'saves the user' do
      expect(context.user.changed?).to be false
    end
  end
end
