require 'rails_helper'

RSpec.describe 'transaction search and filtering', type: :request do
  before :all do
    u_bf = create :user, balance: 1000, name: 'Boba Fett', code: 'BF'
    u_ls = create :user, balance: 2000, name: 'Luke', code: 'LS'
    p_sn = create :product,
                  quantity: 10,
                  name: 'Snickers',
                  price: 100,
                  code: 'PS1',
                  tag_list: 'category:Snack, producer:Mars Inc.'
    p_kk = create :product,
                  quantity: 200,
                  name: 'KitKat',
                  price: 80,
                  code: 'PS2',
                  tag_list: 'category:Snack, producer:Nestlé'
    p_cm = create :product,
                  quantity: 50,
                  name: 'Club Mate',
                  price: 120,
                  code: 'PG1',
                  tag_list: 'category:Getränk, producer:Brauerei Loscher'

    create :transaction,
           items: [
             { pricing: p_sn.pricings.first, quantity: 5 },
             { pricing: p_cm.pricings.first, quantity: 3 }
           ],
           user: u_bf,
           amount: 860,
           created_at: 2.days.ago
    create :transaction,
           items: [
             { pricing: p_sn.pricings.first, quantity: 1 },
             { pricing: p_kk.pricings.first, quantity: 1 },
             { pricing: p_cm.pricings.first, quantity: 3 }
           ],
           user: u_ls,
           amount: 540,
           created_at: 1.days.ago
    create :transaction,
           items: [
             { pricing: p_sn.pricings.first, quantity: 5 }
           ],
           user: u_ls,
           amount: 500
    create :transaction,
           items: [
             { pricing: p_sn.pricings.first, quantity: 5 },
             { pricing: p_cm.pricings.first, quantity: 3 }
           ],
           user: u_bf,
           amount: 860
    create :transaction,
           items: [
             { pricing: p_sn.pricings.first, quantity: 5 },
             { pricing: p_cm.pricings.first, quantity: 3 }
           ],
           user: u_ls,
           amount: 860

    create :transaction,
           transaction_type: 'user_deposit',
           user: u_bf,
           amount: 2000,
           created_at: 2.days.ago + 5.minutes
  end

  after :all do
    DatabaseCleaner.clean_with(:truncation)
  end

  let(:token) { double acceptable?: true }
  before do
    allow_any_instance_of(TransactionsController).
      to receive(:doorkeeper_token) { token }
  end

  let(:subject) { JSON.parse response.body }

  context 'GET /transactions.json' do
    it 'should return all cart_payment transactions' do
      get '/transactions.json'
      expect(subject.size).to eq 5
    end

    it 'should not return user_deposit transactions' do
      get '/transactions.json'
      expect(subject.select { |t| t[:transaction_type] == 'user_deposit' }).
        to be_empty
    end

    it 'should filter by amount' do
      get '/transactions.json?q[amount_gteq]=600'
      expect(subject.size).to eq 3
    end

    it 'should filter by amount and user_name' do
      get '/transactions.json?q[amount_gteq]=600&q[user_name_cont]=Boba'
      expect(subject.size).to eq 2
    end
  end

  context 'POST /transactions/search.json' do
    it 'should return all cart_payment transactions' do
      post '/transactions/search.json'
      expect(subject.size).to eq 5
    end

    it 'should not return user_deposit transactions' do
      post '/transactions/search.json'
      expect(subject.select { |t| t[:transaction_type] == 'user_deposit' }).
        to be_empty
    end

    it 'should filter by amount' do
      post '/transactions/search.json', q: { amount_gteq: 600 }
      expect(subject.size).to eq 3
    end

    it 'should filter by amount and user_name' do
      post '/transactions/search.json',
           q: { amount_gteq: 600, user_name_cont: 'Boba' }
      expect(subject.size).to eq 2
    end

    it 'should filter by transaction_items.name' do
      post '/transactions/search.json',
           q: { transaction_items_name_start: 'Club' }
      expect(subject.size).to eq 4
    end

    it 'should filter by transaction_items.product.tags' do
      post '/transactions/search.json',
           q: { transaction_items_product_tags_name_cont: 'producer:Nestlé' }
      expect(subject.size).to eq 1
    end
  end
end
