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
    response :conflict, 'The user\'s balance is too low'
    response :internal_server_error, 'Something went very wrong'
  end

  swagger_api :index do
    summary 'Find and filter Transactions'
    notes <<-EON
      Filters and returns a transaction list. Only payment transactions are
      returned.
      The proposed query params are only example, many more are possible. If
      the query params string gets too big, please encode the query
      as JSON and POST it to /transactions/search.json.
    EON
    param :query, :'q[user_name_eq]', :string, :optional, 'User name equals'
    param :query, :'q[created_at_gteq]', :string, :optional,
      'Created on or after (date or date and time)'
    param :query, :'q[transaction_items_product_tags_name_eq]', :string,
      :optional, 'One of the bought products\' tags equals'
    response :ok, 'Success', :readTransaction
  end

  swagger_api :search do
    summary 'Find and filter Transactions'
    notes <<-EON
      Filters and returns a transaction list. Only payment transactions are
      returned.
      The query should be a json object of the form
      { "q": { "foo_eq": "abc", "bar_lteq": "12" } }
      but I haven't yet found how to represent that in the current API
      description. The same operators as in GET /transactions.json are
      possible.
    EON
    param :body, :query, :query, :optional, 'Query'
    response :ok, 'Success'
  end

  swagger_model :readTransaction do
    property :id, :integer, :optional, 'Transaction ID'
    property :transaction_type, :string, :optional, 'Transaction type'
    property :user_name, :string, :optional, 'Name of the User at creation time'
    property :user_id, :integer, :optional, 'User ID'
    property :amount, :integer, :optional, 'Transaction amount in €-cent'
    property :created_at, :string, :optional, 'Transaction creation time', format: 'date-time'
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

  swagger_model :query do
    property :q, :object, :optional, :query
  end
  # :nocov:

  before_action :doorkeeper_authorize!, only: [:index, :search]
  before_action -> { doorkeeper_authorize! :checkout }, only: :create

  def create
    result = PayCart.call cart_id: params[:cart_id],
                          requesting_application: doorkeeper_token.application

    if result.success?
      render json: result.transaction, status: :created
    else
      if result.message == 'generic.not_found'
        head :not_found
      elsif result.message == 'user.balance_exceeded'
        head :conflict
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

  alias_method :search, :index
end
