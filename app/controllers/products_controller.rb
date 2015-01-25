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
    response :not_found
  end

  swagger_api :index do
    summary 'Show all products'
  end

  before_action :doorkeeper_authorize!

  def show
    product = Product.find_by_id(params[:id])

    if product.present?
      render json: product
    else
      render_not_found
    end
  end

  def index
    products = Product.all
    render json: products
  end
end
