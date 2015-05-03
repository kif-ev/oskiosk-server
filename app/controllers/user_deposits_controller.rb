class UserDepositsController < ApplicationController
  include Roar::Rails::ControllerAdditions
  include Roar::Rails::ControllerAdditions::Render

  # :nocov:
  swagger_controller :user_deposits, 'Create deposits to user\'s accounts'

  swagger_api :create do
    summary 'Make a deposit to a user\'s account'
    param :path, :user_id, :integer, :required, 'User ID'
    param :body, :deposit, :writeDeposit, :required, 'Deposit'
    response :ok, 'Success'
    response :not_found, 'No user with that ID'
    response :internal_server_error, 'Something went very wrong'
  end

  swagger_model :writeDeposit do
    property :amount, :integer, :required, 'Amount deposited in € cents'
  end
  # :nocov:

  before_action :doorkeeper_authorize!

  def create
    deposit = Deposit.new
    consume!(deposit)

    result = UserDeposit.call(user_id: params[:user_id], amount: deposit.amount)

    if result.success?
      head :no_content
    else
      if result.message == 'user_deposit.not_found'
        head :not_found
      else
        head :internal_server_error
      end
    end
  end
end
