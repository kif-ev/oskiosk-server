class CartsController < ApplicationController
  include Roar::Rails::ControllerAdditions
  include Roar::Rails::ControllerAdditions::Render

  # :nocov:
  swagger_controller :carts, 'Create and update carts'

  swagger_api :show do
    summary 'Fetch a Cart'
    notes <<-EON
      The User ID of the user this cart belongs to is on 'user_id'.
      The cart holds a list of 'cart_items', each of which holding a reference
      to a 'pricing' and a 'quantity' of products reserved at that price.
    EON
    param :path, :id, :integer, :required, 'Cart ID'
    response :ok, 'Success', :readCart
    response :not_found
  end

  swagger_api :create do
    summary 'Create a new cart'
    param :body, :cart, :writeCart, :required, 'Cart'
    response :ok, 'Success', :readCart
    response :bad_request
  end

  swagger_api :update do
    summary 'Update a cart'
    notes <<-EON
      The API supports partial updates, i.e. if you do not want to update the
      attribute `user_id`, you can leave it out from your JSON and it will not
      be reset on the server.
      The `cart_items` doesn't support partial updates yet though and must be
      given in full for each update of `cart_items`.
    EON
    param :path, :id, :integer, :required, 'Cart ID'
    param :body, :cart, :writeCart, :required, 'Cart'
    response :ok, 'Success', :readCart
    response :bad_request
    response :not_found
  end

  swagger_model :readCart do
    property :id, :integer, :optional, 'Cart ID'
    property :user_id, :integer, :optional, 'User ID'
    property :cart_items, :array, :optional, 'Cart Items',
      'items' => {'$ref' => 'readCartItem'}
  end

  swagger_model :readCartItem do
    property :pricing_id, :integer, :optional, 'Pricing ID'
    property :quantity, :integer, :optional, 'Quantity'
    property :product_name, :string, :optional, 'Product name'
    property :unit_price, :integer, :optional, 'Unit price'
    property :total_price, :integer, :optional, 'Total price'
  end

  swagger_model :writeCart do
    property :user_id, :integer, :optional, 'User ID'
    property :cart_items, :array, :optional, 'Cart Items',
      'items' => {'$ref' => 'writeCartItem'}
  end

  swagger_model :writeCartItem do
    property :pricing_id, :integer, :optional, 'Pricing ID'
    property :quantity, :integer, :optional, 'Quantity'
  end
  # :nocov:

  before_action :doorkeeper_authorize!

  def show
    cart = Cart.find_by_id(params[:id])

    if cart.present?
      render json: cart
    else
      render_not_found
    end
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
