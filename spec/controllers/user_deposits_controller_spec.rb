require 'rails_helper'

RSpec.describe UserDepositsController, type: :controller do
  subject { response }

  let(:application) { build_stubbed :doorkeeper_application }
  let(:token) { double acceptable?: true, application: application }
  before { allow(controller).to receive(:doorkeeper_token).and_return(token) }

  let(:transaction) { Transaction.new }
  let(:context) { double success?: true, transaction: transaction }

  describe '#create' do
    before { request.env['CONTENT_TYPE'] = 'application/json' }
    before do
      expect(UserDeposit).to receive(:call).once.
        with(user_id: '1', amount: 1000, requesting_application: application).
        and_return(context)
      post :create, body: JSON.generate(amount: 1000), params: { user_id: '1' }
    end

    context 'with valid parameters' do
      it('passes arguments correctly') {}
      it { is_expected.to have_http_status(:success) }
    end

    context 'with an invalid user_id' do
      let(:context) { double success?: false, message: 'generic.not_found' }

      it { is_expected.to have_http_status(:not_found) }
    end

    context 'something goes wrong' do
      let(:context) { double success?: false, message: 'generic.write_failed' }

      it { is_expected.to have_http_status(:error) }
    end
  end
end
