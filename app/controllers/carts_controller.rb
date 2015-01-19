class CartsController < ApplicationController
  include Roar::Rails::ControllerAdditions
  include Roar::Rails::ControllerAdditions::Render

  before_action :doorkeeper_authorize!

  def show
    cart = Cart.find(params[:id])
    render json: cart
  end

  def create
    cart = Cart.new
    consume!(cart)

    if cart.save
      render json: cart, status: :created, location: cart
    else
      render json: cart.errors, status: :unprocessable_entity
    end
  end

  def update
    cart = Cart.find(params[:id])
    consume!(cart)

    if cart.save
      render json: cart, status: :ok, location: cart
    else
      render json: cart.errors, status: :unprocessable_entity
    end
  end
end
