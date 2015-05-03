require 'rails_helper'

RSpec.describe UserDeposit do
  describe '#call' do
    let(:user) {create(:user, balance: 1000)}
    let(:interactor) {UserDeposit.new(user_id: user.id, amount: 1000)}
    let(:context) {interactor.context}

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
    end
  end
end
