require 'rails_helper'

RSpec.describe IdentifiersController, type: :controller do
  subject {response}

  let(:token) {double acceptable?: true}
  before {allow(controller).to receive(:doorkeeper_token) {token}}

  describe '#show' do
    let(:code) {'U1'}
    before {Identifier.find_by_code('U1').try(:identifiable) || create(:user, code: 'U1')}
    before {Identifier.find_by_code('P1').try(:identifiable) || create(:product, code: 'P1')}

    before {get :show, id: code}

    context 'when the resource exists' do
      its(:content_type) {is_expected.to eq 'application/json'}
      it {is_expected.to have_http_status(:ok)}

      describe 'the JSON response' do
        context 'when the resource is a user' do
          it 'should be of the type user' do
            expect(JSON.parse(subject.body)['type']).to eq 'user'
          end
        end

        context 'when the resource is a product' do
          let(:code) {'P1'}

          it 'should be of the type product' do
            expect(JSON.parse(subject.body)['type']).to eq 'product'
          end
        end
      end
    end
  end
end
