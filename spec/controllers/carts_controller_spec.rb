require 'rails_helper'

RSpec.describe CartsController, type: :controller do
  subject {response}

  let(:token) {double acceptable?: true}
  before {allow(controller).to receive(:doorkeeper_token) {token}}

  let(:valid_attributes) {
    {user_id: 1}
  }

  describe '#show' do
    before {Cart.find_by_id(1) || create(:cart, id: 1)}
    before {get :show, id: cart_id}

    context 'when the resource exists' do
      let(:cart_id) {'1'}
      its(:content_type) {is_expected.to eq 'application/json'}
      it {is_expected.to have_http_status(:ok)}
    end
  end

  describe '#create via JSON' do
    before {request.env['CONTENT_TYPE'] = 'application/json'}

    describe 'with valid parameters' do
      it 'creates a new Cart' do
        expect {
          post :create, JSON.generate(valid_attributes)
        }.to change(Cart, :count).by(1)
      end

      describe 'the request' do
        before {post :create, JSON.generate(valid_attributes)}
        its(:content_type) {is_expected.to eq 'application/json'}
        it {is_expected.to have_http_status(:created)}
      end
    end
  end

  describe '#update via JSON' do
    before do
      cart = Cart.find_by_id(1) || create(:cart, id: 1)
      cart.update_attribute(:user_id, 2)
    end
    before {request.env['CONTENT_TYPE'] = 'application/json'}

    describe 'with valid parameters' do
      it 'updates the Cart 1' do
        cart = Cart.find_by_id(1)
        expect {
          put :update, JSON.generate(valid_attributes), id: '1'
          cart.reload
        }.to change(cart, :user_id).from(2).to(1)
      end

      describe 'the request' do
        before {put :update, JSON.generate(valid_attributes), id: '1'}
        its(:content_type) {is_expected.to eq 'application/json'}
        it {is_expected.to have_http_status(:success)}
      end
    end
  end
end
