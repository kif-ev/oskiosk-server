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
    response :ok, 'Success'
    response :not_found, 'No cart with that ID'
    response :internal_server_error, 'Something went very wrong'
  end

  swagger_model :writeTransaction do
    property :cart_id, :integer, :required, 'Cart ID'
  end
  # :nocov:

  before_action :doorkeeper_authorize!

  def create
    result = PayCart.call(cart_id: params[:cart_id])

    if result.success?
      head :ok
    else
      if result.message == 'pay_cart.not_found'
        head :not_found
      else
        head :internal_server_error
      end
    end
  end
end
