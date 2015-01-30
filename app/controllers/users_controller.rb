class UsersController < ApplicationController
  include Roar::Rails::ControllerAdditions
  include Roar::Rails::ControllerAdditions::Render

  # :nocov:
  swagger_controller :users, 'Manager users'

  swagger_api :show do
    summary 'Fetch a User'
    param :path, :id, :integer, :required, 'User ID'
    response :ok, 'Success', :readUser
    response :not_found
  end

  swagger_model :readUser do
    property :id, :integer, :optional, 'User ID'
    property :name, :string, :optional, 'User Name'
  end
  # :nocov:

  before_action :doorkeeper_authorize!

  def show
    user = User.find_by_id(params[:id])

    if user.present?
      render json: user
    else
      render_not_found
    end
  end
end
