require 'rails_helper'

RSpec.describe PopulateUserDepositTransaction do
  let(:interactor) do
    PopulateUserDepositTransaction.new transaction: transaction, amount: 1000
  end
  let(:context) { interactor.context }

  let(:transaction) { build_stubbed :transaction }

  before { interactor.call }

  it 'succeeds' do
    expect(context).to be_a_success
  end

  it 'sets the transaction type' do
    expect(context.transaction.transaction_type).to eq('user_deposit')
  end

  it 'sets the transaction amount' do
    expect(context.transaction.amount).to eq(1000)
  end
end
