class AdminsController < APIController
  # :nocov:
  swagger_controller :admins, 'Manager admins'

  swagger_api :show do
    summary 'Fetch an admin'
    param :path, :id, :integer, :required, 'Admin ID'
    response :ok, 'Success', :readAdmin
    response :not_found
  end

  swagger_api :index do
    summary 'Show all admins'
    response :ok, 'Success', :readAdmin
  end

  swagger_api :create do
    summary 'Create a new admin'
    param :body, :admin, :writeAdmin, :required, 'Admin'
    response :ok, 'Success', :readAdmin
    response :conflict, 'Conflict', :readAdmin
    response :bad_request
  end

  swagger_api :update do
    summary 'Update an admin'
    notes 'Supports partial updates'
    param :path, :id, :integer, :required, 'Admin ID'
    param :body, :admin, :writeAdmin, :required, 'Admin'
    response :ok, 'Success', :readAdmin
    response :conflict, 'Conflict', :readAdmin
    response :not_found
  end

  swagger_model :readAdmin do
    property :id, :integer, :optional, 'Admin ID'
    property :email, :string, :optional, 'Admin Email'
  end

  swagger_model :writeAdmin do
    property :email, :string, :optional, 'Admin Email'
    property :password, :string, :optional, 'Admin Password'
  end
  # :nocov:

  before_action :authenticate_admin!

  def show
    admin = Admin.find_by_id(params[:id])

    if admin.present?
      render json: admin
    else
      render_not_found
    end
  end

  def index
    admins = Admin.all

    render json: admins
  end

  def create
    admin = Admin.new
    consume!(admin)

    if admin.save
      render json: admin, status: :created, location: admin
    else
      render json: admin, status: :conflict, location: admin
    end
  end

  def update
    admin = Admin.find(params[:id])
    consume!(admin)

    if admin.save
      render json: admin, status: :ok, location: admin
    else
      render json: admin, status: :conflict, location: admin
    end
  end

  def destroy
    admin = Admin.find_by_id(params[:id])

    if admin.present?
      admin.destroy
      render_no_content
    else
      render_not_found
    end
  end
end
