class UsersController < ApplicationController
  # :nocov:
  swagger_controller :users, 'Manager users'

  swagger_api :show do
    summary 'Fetch a User'
    param :path, :id, :integer, :required, 'User ID'
    response :ok, 'Success', :readUser
    response :not_found
  end

  swagger_api :index do
    summary 'Show all users'
    response :ok, 'Success', :readUser
  end

  swagger_model :readUser do
    property :id, :integer, :optional, 'User ID'
    property :name, :string, :optional, 'User Name'
    property :balance, :integer, :optional, 'User\'s balance in € cent'
    property :tags, :array, :optional, 'Tags',
      'items' => {'type' => 'string'}
  end
  # :nocov:

  before_action :doorkeeper_authorize!, only: [:show]
  before_action -> { doorkeeper_authorize! :admin, :cash_desk }, only: [:index]

  def show
    user = User.find_by_id(params[:id])

    if user.present?
      render json: user
    else
      render_not_found
    end
  end

  def index
    users = User.all

    render json: users
  end
end
