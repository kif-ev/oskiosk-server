class ProductsController < ApplicationController
  include Roar::Rails::ControllerAdditions
  include Roar::Rails::ControllerAdditions::Render

  before_action :doorkeeper_authorize!

  def show
    product = Product.find(params[:id])
    render json: product
  end

  def index
    products = Product.all
    render json: products
  end
end
