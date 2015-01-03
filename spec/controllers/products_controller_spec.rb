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
end
