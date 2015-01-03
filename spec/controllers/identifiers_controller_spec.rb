require 'rails_helper'

RSpec.describe IdentifiersController, type: :controller do
  subject {response}

  describe '#show' do
    context 'when the resource is a user' do
      before {get :show, id: 'U1'}

      context 'when the resource exists' do
        before(:all) {Identifier.find_by_code('U1').try(:identifiable) || create(:user, code: 'U1')}
        its(:content_type) {is_expected.to eq 'application/json'}
        it {is_expected.to have_http_status(:ok)}

        context 'the JSON response' do
          subject {JSON.parse(response.body)}

          its(['type']) {is_expected.to eq 'user'}
        end
      end
    end

    context 'when the resource is a product' do
      before {get :show, id: 'P1'}

      context 'when the resource exists' do
        before(:all) {Identifier.find_by_code('P1').try(:identifiable) || create(:product, code: 'P1')}
        its(:content_type) {is_expected.to eq 'application/json'}
        it {is_expected.to have_http_status(:ok)}

        context 'the JSON response' do
          subject {JSON.parse(response.body)}

          its(['type']) {is_expected.to eq 'product'}
        end
      end
    end
  end
end
