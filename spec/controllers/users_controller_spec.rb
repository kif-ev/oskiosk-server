require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  subject {response}

  let(:token) {double acceptable?: true}
  before {allow(controller).to receive(:doorkeeper_token) {token}}

  let (:valid_attributes) {
    { name: 'Howard' }
  }

  describe '#show' do
    before {User.find_by_id(1) || create(:user, id: 1)}
    before { get :show, params: { id: user_id } }

    context 'when the resource exists' do
      let(:user_id) {'1'}

      its(:media_type) { is_expected.to eq 'application/json' }
      it {is_expected.to have_http_status(:ok)}
    end

    context 'when the resource doesn\'t exist' do
      let(:user_id) {'2'}

      it {is_expected.to have_http_status(:not_found)}
    end
  end

  describe '#create via JSON' do
    before { request.env['CONTENT_TYPE'] = 'application/json' }

    describe 'with valid parameters' do
      it 'creates a new User' do
        expect {
          post :create, body: JSON.generate(valid_attributes)
        }.to change(User, :count).by(1)
      end

      describe 'the request' do
        before { post :create, body: JSON.generate(valid_attributes) }

        its(:media_type) { is_expected.to eq 'application/json' }
        it { is_expected.to have_http_status(:created) }
      end
    end
  end

  describe '#update via JSON' do
    before do
      user = User.find_by_id(1) || create(:user, id: 1)
      user.update_attribute(:name, 'Sheldon')
    end
    before { request.env['CONTENT_TYPE'] = 'application/json' }

    describe 'with valid parameters' do
      it 'updates the User 1' do
        user = User.find_by_id(1)
        expect {
          put :update, body: JSON.generate(valid_attributes), params: { id: '1' }
          user.reload
        }.to change(user, :name).from('Sheldon').to('Howard')
      end
    end

    describe 'the request' do
      before { put :update, body: JSON.generate(valid_attributes), params: { id: '1' } }

      its(:media_type) { is_expected.to eq 'application/json' }
      it {is_expected.to have_http_status(:success)}
    end
  end
end
