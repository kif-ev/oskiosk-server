class UsersController < ApplicationController
  include Roar::Rails::ControllerAdditions
  include Roar::Rails::ControllerAdditions::Render

  swagger_controller :users, 'Manager users'

  swagger_api :show do
    summary 'Fetch the user'
  end

  before_action :doorkeeper_authorize!

  def show
    user = User.find_by_id(params[:id])
    render json: user
  end
end
