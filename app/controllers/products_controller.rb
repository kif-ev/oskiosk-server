class ProductsController < ApplicationController
  # :nocov:
  swagger_controller :products, 'Manage products, their prices and quantities'

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

  swagger_api :create do
    summary 'Create a new product'
    param :body, :product, :writeProduct, :required, 'Product'
    response :ok, 'Success', :readProduct
    response :conflict, 'Conflict', :readProduct
    response :bad_request
  end

  swagger_api :update do
    summary 'Update a product'
    notes 'Supports partial updates'
    param :path, :id, :integer, :required, 'Product ID'
    param :body, :product, :writeProduct, :required, 'Product'
    response :ok, 'Success', :readProduct
    response :conflict, 'Conflict', :readProduct
    response :not_found
  end

  swagger_model :readProduct do
    description 'A Product object'
    property :id, :integer, :optional, 'Product ID'
    property :name, :string, :optional, 'Product name'
    property :quantity, :integer, :optional, 'Total quantity'
    property :available_quantity, :integer, :optional, 'Available quantity'
    property :tags, :array, :optional, 'Tags',
      'items' => {'type' => 'string'}
    property :pricings, :array, :optional, 'Pricings',
      'items' => {'$ref' => 'readPricing'}
    property :identifiers, :array, :optional, 'Identifiers',
      'items' => {'$ref' => 'readIdentifier'}
  end

  swagger_model :readPricing do
    description 'A Product\'s Pricing'
    property :id, :integer, :optional, 'Pricing ID'
    property :quantity, :integer, :optional, 'Total quantity'
    property :available_quantity, :integer, :optional, 'Available quantity'
    property :price, :integer, :optional, 'Product price'
  end

  swagger_model :readIdentifier do
    description 'A Product\'s or User\'s Identifier'
    property :code, :string, :required, 'Identifying code'
  end

  swagger_model :writeProduct do
    property :name, :string, :optional, 'Product name'
    property :tags, :array, :optional, 'Tags',
      'items' => { 'type' => 'string' }
    property :pricings, :array, :optional, 'Pricings',
      'items' => { '$ref' => 'writePricing' }
    property :identifiers, :array, :optional, 'Identifiers',
      'items' => { '$ref' => 'writeIdentifier' }
  end

  swagger_model :writePricing do
    property :quantity, :integer, :required, 'Total quantity'
    property :price, :integer, :optional, 'Product price'
  end

  swagger_model :writeIdentifier do
    property :code, :string, :required, 'Identifying code'
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

  def create
    product = Product.new
    consume!(product)

    if product.save
      render json: product, status: :created, location: product
    else
      render json: product, status: :conflict, location: product
    end
  end

  def update
    product = Product.find(params[:id])
    consume!(product)

    if product.save
      render json: product, status: :ok, location: product
    else
      render json: product, status: :conflict, location: product
    end
  end
end
