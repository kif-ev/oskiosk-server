class ProductsController < ApplicationController
  include Roar::Rails::ControllerAdditions
  include Roar::Rails::ControllerAdditions::Render

  # :nocov:
  swagger_controller :products, 'Manage products and their prices'

  swagger_api :show do
    summary 'Fetch the product and its prices'
    notes <<-EON
      The prices are defined in the 'pricings' list, each 'pricing' holds the
      price and quantity available at that price
    EON
    param :path, :id, :integer, :required, 'Product ID'
    response :ok, 'Success', :readProduct
    response :not_found
  end

  swagger_api :index do
    summary 'Show all products'
    response :ok, 'Success', :readProduct
  end

  swagger_model :readProduct do
    description 'A Product object'
    property :id, :integer, :optional, 'Product ID'
    property :name, :string, :optional, 'Product name'
    property :quantity, :integer, :optional, 'Total quantity'
    property :available_quantity, :integer, :optional, 'Available quantity'
    property :pricings, :array, :optional, 'Pricings',
      'items' => {'$ref' => 'readPricing'}
  end

  swagger_model :readPricing do
    description 'A Product\'s Pricing'
    property :id, :integer, :optional, 'Pricing ID'
    property :quantity, :integer, :optional, 'Total quantity'
    property :available_quantity, :integer, :optional, 'Available quantity'
    property :price, :integer, :optional, 'Product price'
  end
  # :nocov:

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
