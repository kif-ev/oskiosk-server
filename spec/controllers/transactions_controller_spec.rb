require 'rails_helper'

RSpec.describe TransactionsController, type: :controller do
  subject { response }

  let(:token) { double acceptable?: true, application: application }
  let(:application) { build :doorkeeper_application }
  before { allow(controller).to receive(:doorkeeper_token).and_return(token) }
end
