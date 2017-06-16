require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  subject {response}

  let(:token) {double acceptable?: true}
  before {allow(controller).to receive(:doorkeeper_token) {token}}

  let (:valid_attributes) {
    { name: 'Perriair' }
  }

  describe '#show' do
    before { Product.find_by(id: 1) || create(:product, id: 1) }
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
      before do
        (1..3).each { |y| Product.find_by(id: y) || create(:product, id: y) }
      end

      its(:content_type) {is_expected.to eq 'application/json'}
      it {is_expected.to have_http_status(:ok)}
    end

    context 'when there are no products' do
      its(:content_type) {is_expected.to eq 'application/json'}
      it {is_expected.to have_http_status(:ok)}
    end
  end

  describe '#create via JSON' do
    before { request.env['CONTENT_TYPE'] = 'application/json' }

    describe 'with valid parameters' do
      it 'creates a new Product' do
        expect {
          post :create, body: JSON.generate(valid_attributes)
        }.to change(Product, :count).by(1)
      end

      describe 'the request' do
        before { post :create, body: JSON.generate(valid_attributes) }

        its(:content_type) { is_expected.to eq 'application/json' }
        it { is_expected.to have_http_status(:created) }
      end
    end
  end

  describe '#update via JSON' do
    before do
      product = Product.find_by(id: 1) || create(:product, id: 1)
      product.update_attribute(:name, 'Turbriskafil')
    end
    before { request.env['CONTENT_TYPE'] = 'application/json' }

    describe 'with valid parameters' do
      it 'updates the Product 1' do
        product = Product.find_by(id: 1)
        expect {
          put :update, body: JSON.generate(valid_attributes), params: { id: '1' }
          product.reload
        }.to change(product, :name).from('Turbriskafil').to('Perriair')
      end
    end

    describe 'the request' do
      before { put :update, body: JSON.generate(valid_attributes), params: { id: '1' } }

      its(:content_type) {is_expected.to eq 'application/json'}
      it {is_expected.to have_http_status(:success)}
    end
  end
end
