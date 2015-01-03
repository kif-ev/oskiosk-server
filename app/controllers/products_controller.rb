class ProductsController < ApplicationController
  include Roar::Rails::ControllerAdditions
  include Roar::Rails::ControllerAdditions::Render

  def show
    product = Product.find(params[:id])
    render json: product
  end
end
