class ProductsController < ApplicationController
  include Roar::Rails::ControllerAdditions
  include Roar::Rails::ControllerAdditions::Render

  swagger_controller :products, 'Manage products and their prices'

  swagger_api :show do
    summary 'Fetch the product and its prices'
    notes <<-EON
      The prices are defined in the 'pricings' list, each 'pricing' holds the
      price and quantity available at that price
   EON
   param :path, :id, :integer, :required, 'The product ID'
  end

  swagger_api :index do
    summary 'Show all products'
  end

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
