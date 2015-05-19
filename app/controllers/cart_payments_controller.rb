class CartPaymentsController < ApplicationController
  include Roar::Rails::ControllerAdditions
  include Roar::Rails::ControllerAdditions::Render

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
    response :ok, 'Success', :readTransaction
    response :not_found, 'No cart with that ID'
    response :conflict, 'The user\'s balance is too low'
    response :internal_server_error, 'Something went very wrong'
  end
  # :nocov:

  before_action -> { doorkeeper_authorize! :checkout }

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
end
