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

  swagger_api :create do
    summary 'Create a new user'
    param :body, :user, :writeUser, :required, 'User'
    response :ok, 'Success', :readUser
    response :conflict, 'Conflict', :readUser
    response :bad_request
  end

  swagger_api :update do
    summary 'Update a user'
    notes 'Supports partial updates'
    param :path, :id, :integer, :required, 'User ID'
    param :body, :user, :writeUser, :required, 'User'
    response :ok, 'Success', :readUser
    response :conflict, 'Conflict', :readUser
    response :not_found
  end

  swagger_model :readUser do
    property :id, :integer, :optional, 'User ID'
    property :name, :string, :optional, 'User Name'
    property :balance, :integer, :optional, 'User\'s balance in € cent'
    property :allow_negative_balance, :boolean, :optional,
             'Whether the user can have a negative balance (pre/postpaid)'
    property :tags, :array, :optional, 'Tags',
      'items' => { 'type' => 'string' }
    property :identifiers, :array, :optional, 'Identifiers',
      'items' => { '$ref' => 'readIdentifier' }
  end

  swagger_model :readIdentifier do
    description 'A Product\'s or User\'s Identifier'
    property :code, :string, :required, 'Identifying code'
  end

  swagger_model :writeUser do
    property :name, :string, :optional, 'User name'
    property :tags, :array, :optional, 'Tags',
      'items' => { 'type' => 'string' }
    property :identifiers, :array, :optional, 'Identifiers',
      'items' => { '$ref' => 'writeIdentifier' }
  end

  swagger_model :writeIdentifier do
    property :code, :string, :required, 'Identifying code'
  end
  # :nocov:

  before_action :doorkeeper_authorize!, only: [:show]
  before_action -> { doorkeeper_authorize! :admin, :cash_desk }, only: [:index]
  before_action -> { doorkeeper_authorize! :admin }, only: [:create, :update]

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

  def create
    user = User.new
    consume!(user)

    if user.save
      render json: user, status: :created, location: user
    else
      render json: user, status: :conflict, location: user
    end
  end

  def update
    user = User.find(params[:id])
    consume!(user)

    if user.save
      render json: user, status: :ok, location: user
    else
      render json: user, status: :conflict, location: user
    end
  end
end
