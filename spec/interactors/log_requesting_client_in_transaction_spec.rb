require 'rails_helper'

RSpec.describe LogRequestingClientInTransaction do
  describe '#call' do
    let(:interactor) do
      LogRequestingClientInTransaction.new transaction: transaction,
                                           requesting_application: application
    end
    let(:context) { interactor.context }

    let(:transaction) { build :transaction }
    let(:application) do
      build_stubbed :doorkeeper_application, name: 'Verkaufspunkt 1'
    end

    before { interactor.call }

    it 'succeeds' do
      expect(context).to be_a_success
    end

    it 'logs the client app\'s name in the transaction' do
      expect(context.transaction.application_name).to eq('Verkaufspunkt 1')
    end

    it 'logs the client app in the transaction' do
      expect(context.transaction.application).to eq(application)
    end
  end
end
