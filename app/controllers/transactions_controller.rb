class TransactionsController < ApplicationController
  include Roar::Rails::ControllerAdditions
  include Roar::Rails::ControllerAdditions::Render

  before_action :doorkeeper_authorize!

  def create
    result = PayCart.call(cart_id: params[:cart_id])
    head :no_content
  end
end
