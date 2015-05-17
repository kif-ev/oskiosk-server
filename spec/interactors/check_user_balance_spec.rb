require 'rails_helper'

RSpec.describe CheckUserBalance do
  let(:interactor) do
    CheckUserBalance.new(user: user, transaction: transaction)
  end
  let(:context) { interactor.context }

  let(:user) { double balance: 100, allow_negative_balance?: true }
  let(:transaction) { double amount: -300 }

  context 'when the user is authorized a negative balance' do
    it 'does nothing' do
      interactor.call
      expect(context).to be_a_success
    end
  end

  context 'when the user is not authorized a negative balance' do
    let(:user) { double balance: 100, allow_negative_balance?: false }

    context 'and doesn\'t have enough money' do
      it 'fails' do
        interactor.call rescue Interactor::Failure
        expect(context).to_not be_a_success
      end

      it 'sets the error message' do
        interactor.call rescue Interactor::Failure
        expect(context.message).to eq('user.balance_exceeded')
      end
    end

    context 'and has enough money' do
      let(:user) { double balance: 300, allow_negative_balance?: false }

      it 'does nothing' do
        interactor.call
        expect(context).to be_a_success
      end
    end
  end
end
