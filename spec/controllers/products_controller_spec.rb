require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  subject {response}

  let(:token) {double acceptable?: true}
  before {allow(controller).to receive(:doorkeeper_token) {token}}

  describe '#show' do
    before {Product.find_by_id(1) || create(:product, id: 1)}
    before { get :show, params: { id: product_id } }

    context 'when the resource exists' do
      let(:product_id) {'1'}

      its(:content_type) {is_expected.to eq 'application/json'}
      it {is_expected.to have_http_status(:ok)}
    end

    context 'when the resource doesn\'t exist' do
      let(:product_id) {'2'}

      it {is_expected.to have_http_status(:not_found)}
    end
  end

  describe '#index' do
    before {get :index}

    context 'when there are products' do
      before {(1..3).each {|y| Product.find_by_id(y) || create(:product, id: y)}}

      its(:content_type) {is_expected.to eq 'application/json'}
      it {is_expected.to have_http_status(:ok)}
    end

    context 'when there are no products' do
      its(:content_type) {is_expected.to eq 'application/json'}
      it {is_expected.to have_http_status(:ok)}
    end
  end
end
