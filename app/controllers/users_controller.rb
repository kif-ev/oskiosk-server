class UsersController < ApplicationController
  include Roar::Rails::ControllerAdditions
  include Roar::Rails::ControllerAdditions::Render

  swagger_controller :users, 'Manager users'

  swagger_api :show do
    summary 'Fetch the user'
    response :not_found
  end

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
