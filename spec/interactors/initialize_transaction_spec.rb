require 'rails_helper'

RSpec.describe InitializeTransaction do
  describe '#call' do
    let(:interactor) { InitializeTransaction.new user: user }
    let(:context) { interactor.context }

    let(:user) { build_stubbed :user }

    before { interactor.call }

    it 'succeeds' do
      expect(context).to be_a_success
    end

    it 'should add a transaction to the context' do
      expect(context.transaction).to be_a(Transaction)
    end

    it 'populates the transaction' do
      expect(context.transaction.user).to eq(user)
      expect(context.transaction.user_name).to eq(user.name)
    end
  end
end
