class CartPaymentsController < ApplicationController
  # :nocov:
  swagger_controller :cart_payments, 'Pay for a cart'

  swagger_api :create do
    summary 'Process a Transaction'
    notes <<-EON
      Create a transaction from a cart.
      The products in the corresponding cart will be removed and the
      value deduced from the user's balance
    EON
    param :path, :cart_id, :integer, :required, 'Cart ID'
    param :body, :cart, :versionCart, :required, 'Cart'
    response :ok, 'Success', :readTransaction
    response :not_found, 'No cart with that ID or it is expired'
    response :conflict, 'The user\'s balance is too low'
    response :precondition_required, 'The cart is stale'
    response :gone, 'The cart payment is already being processed'
    response :internal_server_error, 'Something went very wrong'
  end

  swagger_model :versionCart do
    property :lock_version, :integer, :required, 'Cart Version'
  end
  # :nocov:

  before_action -> { doorkeeper_authorize! :checkout }

  def create
    result = PayCart.call cart_id: params[:cart_id],
                          cart_version: params[:lock_version],
                          requesting_application: doorkeeper_token.application

    if result.success?
      render json: result.transaction, status: :created
    else
      if result.message == 'generic.not_found'
        head :not_found
      elsif result.message == 'user.balance_exceeded'
        head :conflict
      elsif result.message == 'generic.stale'
        head :precondition_required
      elsif result.message == 'generic.processing'
        head :gone
      else
        head :internal_server_error
      end
    end
  end
end
