require 'rails_helper'

RSpec.describe CommitTransaction do
  let(:interactor) { CommitTransaction.new transaction: transaction }
  let(:context) { interactor.context }

  let(:transaction) { build_stubbed :transaction }

  describe '#call' do
    context 'when all is well' do
      before do
        expect(transaction).to receive(:save!)
      end

      before { interactor.call }

      it 'succeeds' do
        expect(context).to be_a_success
      end
    end

    context 'when stuff fails' do
      before do
        allow(transaction).to receive(:save!).
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
    it 'should delete the transaction from the DB' do
      expect(transaction).to receive(:destroy!)
      interactor.rollback
    end
  end
end
