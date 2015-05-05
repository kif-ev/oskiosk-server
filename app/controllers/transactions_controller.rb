class TransactionsController < ApplicationController
  include Roar::Rails::ControllerAdditions
  include Roar::Rails::ControllerAdditions::Render

  # :nocov:
  swagger_controller :transactions, 'Create transactions'

  swagger_api :create do
    summary 'Process a Transaction'
    notes <<-EON
      Create a transaction from a cart.
      The products in the corresponding cart will be removed and the
      value deduced from the user's balance
    EON
    param :body, :transaction, :writeTransaction, :required, 'Transaction'
    response :ok, 'Success', :readTransaction
    response :not_found, 'No cart with that ID'
    response :internal_server_error, 'Something went very wrong'
  end

  swagger_api :index do
    summary 'Find and filter Transactions'
    notes 'foobar'
    param :body, :query, :writeTransaction, :required
    response :ok, 'Success'
  end

  swagger_model :readTransaction do
    property :id, :integer, :optional, 'Transaction ID'
    property :transaction_type, :string, :optional, 'Transaction type'
    property :user_name, :string, :optional, 'Name of the User at creation time'
    property :user_id, :integer, :optional, 'User ID'
    property :amount, :integer, :optional, 'Transaction amount in €-cent'
    property :created_at, :string, :optional, 'Transaction creation time'
    property :transaction_items, :array, :optional, 'Transaction Items',
      'items' => {'$ref' => 'readTransactionItem'}
  end

  swagger_model :readTransactionItem do
    property :id, :integer, :optional, 'Transaction Item ID'
    property :product_id, :integer, :optional, 'Product ID'
    property :price, :integer, :optional,
      'Price of the Product at creation time'
    property :name, :integer, :optional, 'Name of the Product at creation time'
    property :quantity, :integer, :optional, 'Quantity'
  end

  swagger_model :writeTransaction do
    property :cart_id, :integer, :required, 'Cart ID'
  end
  # :nocov:

  before_action :doorkeeper_authorize!

  def create
    result = PayCart.call(cart_id: params[:cart_id])

    if result.success?
      render json: result.transaction, status: :created
    else
      if result.message == 'pay_cart.not_found'
        head :not_found
      else
        head :internal_server_error
      end
    end
  end

  def index
    results = Transaction.where(transaction_type: 'cart_payment').
              ransack(params[:q]).result

    render json: results, status: :ok
  end
end
