require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  subject {response}

  describe '#show' do
    before {get :show, id: '1'}

    context 'when the resource exists' do
      before(:all) {Product.find_by_id(1) || create(:product, id: 1)}
      its(:content_type) {is_expected.to eq 'application/json'}
      it {is_expected.to have_http_status(:ok)}
    end
  end

  describe '#index' do
    before {get :index}

    context 'when there are products' do
      before(:all) {(1..3).each {|y| Product.find_by_id(y) || create(:product, id: y)}}
      its(:content_type) {is_expected.to eq 'application/json'}
      it {is_expected.to have_http_status(:ok)}
    end

    context 'when there are no products' do
      before(:all) {Product.destroy_all}
      its(:content_type) {is_expected.to eq 'application/json'}
      it {is_expected.to have_http_status(:ok)}
    end
  end
end
