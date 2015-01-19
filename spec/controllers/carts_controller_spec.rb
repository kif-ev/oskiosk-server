require 'rails_helper'

RSpec.describe CartsController, type: :controller do
  subject {response}

  let(:token) {double acceptable?: true}
  before {allow(controller).to receive(:doorkeeper_token) {token}}

  let(:valid_attributes) {
    {user_id: 1}
  }

  describe '#show' do
    before {get :show, id: '1'}

    context 'when the resource exists' do
      before(:all) {Cart.find_by_id(1) || create(:cart, id: 1)}
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
        it {is_expected.to have_http_status(:ok)}
      end
    end
  end

  describe '#update via JSON' do
    before(:all) do
      cart = Cart.find_by_id(1) || create(:cart, id: 1)
      cart.update_attribute(:user_id, 2)
    end

    describe 'with valid parameters', type: :request do
      it 'updates the Cart 1' do
        cart = Cart.find_by_id(1)
        expect {
          put(cart_path(id: 1, format: :json), JSON.generate(valid_attributes), {'CONTENT_TYPE' => 'application/json'})
          cart.reload
        }.to change(cart, :user_id).from(2).to(1)
      end

      describe 'the request' do
        before {put(cart_path(id: 1, format: :json), JSON.generate(valid_attributes), {'CONTENT_TYPE' => 'application/json'})}
        its(:content_type) {is_expected.to eq nil}
        it {is_expected.to have_http_status(:success)}
      end
    end
  end
end
