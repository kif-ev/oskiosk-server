class TransactionsController < ApplicationController
  include Roar::Rails::ControllerAdditions
  include Roar::Rails::ControllerAdditions::Render

  # :nocov:
  swagger_controller :transactions, 'Create transactions'

  swagger_api :create do
    summary 'Process a transaction'
    notes <<-EON
      Create a transaction from a cart.
      The products in the corresponding cart will be removed and the
      value deduced from the user's balance
    EON
    param :body, :transaction, :string, :required, 'JSON containing the `cart_id`'
  end
  # :nocov:

  before_action :doorkeeper_authorize!

  def create
    result = PayCart.call(cart_id: params[:cart_id])
    head :no_content
  end
end
