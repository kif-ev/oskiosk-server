require 'rails_helper'

RSpec.describe UserDeposit do
  describe '#call' do
    let(:user) { create :user, balance: 1000 }
    let(:application) { build_stubbed :doorkeeper_application }
    let(:interactor) do
      UserDeposit.new user_id: user.id,
                      amount: 1000,
                      requesting_application: application
    end
    let(:context) { interactor.context }

    context 'when everything is swell' do
      it 'succeeds' do
        interactor.call
        expect(context).to be_a_success
      end

      it 'updates the user\'s balance' do
        expect {interactor.call && user.reload}.to change(user, :balance).
          from(1000).to(2000)
      end

      it 'creates a transaction' do
        expect {interactor.call}.to change(Transaction, :count).by(1)
      end

      it 'assigns the transaction to the context' do
        interactor.call
        expect(context.transaction).to_not be_nil
      end
    end

    context 'when there\'s no user with that ID' do
      before do
        allow(User).to receive(:find_by_id!).
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

    context 'when things go wrong' do
      before do
        allow_any_instance_of(Transaction).to receive(:save!).
          and_raise(ActiveRecord::ActiveRecordError)
      end

      before { interactor.call rescue Interactor::Failure }

      it 'fails' do
        expect(context).to_not be_a_success
      end

      it 'sets the correct error message' do
        expect(context.message).to eq('generic.write_failed')
      end

      it 'should not update the user\'s balance' do
        # reload is needed as AR transaction rollbacks only affect
        # the DB, not the corresponding AR object
        expect(user.reload.balance).to eq(1000)
      end
    end
  end
end
