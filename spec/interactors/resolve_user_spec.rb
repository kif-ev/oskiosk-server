require 'rails_helper'

RSpec.describe ResolveUser do
  let(:interactor) { ResolveUser.new user_id: 1 }
  let(:context) { interactor.context }

  let(:user) { double }

  context 'when the user exists' do
    before do
      allow(User).to receive(:find_by_id!).with(1).and_return(user)
    end

    before { interactor.call }

    it 'succeeds' do
      expect(context).to be_a_success
    end

    it 'sets the user in the context' do
      expect(context.user).to eq(user)
    end
  end

  context 'when the user doesn\'t exist' do
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
end
