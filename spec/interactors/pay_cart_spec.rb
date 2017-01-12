require 'rails_helper'

RSpec.describe PayCart do
  describe '#call' do
    let(:interactor) do
      PayCart.new(
        cart_id: cart.id,
        cart_version: 3,
        requesting_application: application
      )
    end
    let(:context) { interactor.context }
    let(:user) { create :user, balance: 1000 }
    let(:pricings) do
      [
        create(:pricing, price: 50, quantity: 5),
        create(:pricing, price: 200, quantity: 5)
      ]
    end
    let(:cart_items) do
      [
        create(:cart_item, quantity: 2, pricing: pricings[0]),
        create(:cart_item, quantity: 1, pricing: pricings[1])
      ]
    end
    let(:cart) do
      create :cart, user: user, cart_items: cart_items, lock_version: 3
    end
    let(:application) do
      create :doorkeeper_application, name: 'Verkaufspunkt'
    end

    before do
      allow(Cart).to receive(:find_by_id!).with(cart.id).and_return(cart)
    end

    context 'when everything is swell' do
      it 'succeeds' do
        interactor.call
        expect(context).to be_a_success
      end

      it 'updates the first product\'s quantities' do
        expect { interactor.call }.to change(pricings[0], :quantity).
          from(5).to(3)
      end
      it 'updates the second product\'s quantities' do
        expect { interactor.call }.to change(pricings[1], :quantity).
          from(5).to(4)
      end

      it 'debits the user correctly' do
        expect { interactor.call }.to change(user, :balance).from(1000).to(700)
      end

      it 'deletes the cart' do
        expect(cart).to receive(:destroy!)
        interactor.call
      end

      it 'deletes the cart_items' do
        expect { interactor.call }.to change(CartItem, :count).by(-2)
      end

      it 'creates a transaction' do
        expect { interactor.call }.to change(Transaction, :count).by(1)
      end

      it 'creates transaction_items' do
        expect { interactor.call }.to change(TransactionItem, :count).by(2)
      end

      it 'assigns the transaction to the context' do
        interactor.call
        expect(context.transaction).to_not be_nil
      end
    end

    context 'when the user doesn\'t have enough money' do
      context 'when the user is allowed a negative balance' do
        let(:user) { create :user, balance: 100, allow_negative_balance: true }

        it 'lets the user pay for the cart' do
          interactor.call
          expect(context).to be_a_success
        end

        it 'debits the user correctly' do
          expect { interactor.call }.to change(user, :balance).
            from(100).to(-200)
        end
      end

      context 'when the user is not allowed a negative balance' do
        let(:user) { create :user, balance: 100 }

        it 'doesn\'t let the user pay for the cart' do
          interactor.call rescue Interactor::Failure
          expect(context).to_not be_a_success
        end

        it 'doesn\'t debit the user' do
          expect { interactor.call rescue Interactor::Failure }.
            to_not change(user, :balance)
        end
      end
    end

    context 'when there\'s no cart with that ID' do
      before do
        allow(Cart).to receive(:find_by_id!).with(cart.id).
          and_raise(ActiveRecord::RecordNotFound)
      end

      it 'fails' do
        interactor.call rescue Interactor::Failure
        expect(context).to_not be_a_success
      end

      it 'sets the correct error message' do
        interactor.call rescue Interactor::Failure
        expect(context.message).to eq('generic.not_found')
      end
    end

    context 'when things go wrong' do
      before do
        allow_any_instance_of(Cart).to receive(:destroy!).
          and_raise(ActiveRecord::ActiveRecordError)
      end

      it 'fails' do
        interactor.call rescue Interactor::Failure
        expect(context).to_not be_a_success
      end

      it 'sets the correct error message' do
        interactor.call rescue Interactor::Failure
        expect(context.message).to eq('generic.write_failed')
      end

      it 'should not create a transaction' do
        expect { interactor.call rescue Interactor::Failure }.
          to_not change(Transaction, :count)
      end

      it 'should not create transaction_items' do
        expect { interactor.call rescue Interactor::Failure }.
          to_not change(TransactionItem, :count)
      end

      it 'should not delete the cart' do
        expect { interactor.call rescue Interactor::Failure }.
          to_not change(Cart, :count)
      end

      it 'should not charge the user' do
        expect { interactor.call rescue Interactor::Failure }.
          to_not change(user, :balance)
      end
    end

    context 'when things come in fast', :transactional do
      it 'shouldn\'t do things twice' do
        expect do
          threaded(3) do
            PayCart.new(
              cart_id: cart.id,
              cart_version: 3,
              requesting_application: application
            ).call rescue Interactor::Failure
          end
        end.to change(user, :balance).from(1000).to(700)
      end
    end
  end

  def threaded(count, &block)
    threads = []
    count.times do |i|
      threads << Thread.new(i) do
        ActiveRecord::Base.connection_pool.with_connection do
          begin
            yield
          rescue Exception => e
            Thread.current[:exception] = e.message
          end
        end
      end
    end
    threads.each do |thread|
      thread.join
      assert_nil thread[:exception]
    end
  end
end
