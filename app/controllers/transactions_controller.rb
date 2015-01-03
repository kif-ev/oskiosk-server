class TransactionsController < ApplicationController
  include Roar::Rails::ControllerAdditions
  include Roar::Rails::ControllerAdditions::Render

  def create
    result = PayCart.call(cart_id: params[:cart_id])
    head :no_content
  end
end
