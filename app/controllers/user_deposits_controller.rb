class UserDepositsController < ApplicationController
  # :nocov:
  swagger_controller :user_deposits, 'Create deposits to user\'s accounts'

  swagger_api :create do
    summary 'Make a deposit to a user\'s account'
    param :path, :user_id, :integer, :required, 'User ID'
    param :body, :deposit, :writeDeposit, :required, 'Deposit'
    response :ok, 'Success', :readTransaction
    response :not_found, 'No user with that ID'
    response :internal_server_error, 'Something went very wrong'
  end

  swagger_model :writeDeposit do
    property :amount, :integer, :required, 'Amount deposited in € cents'
  end
  # :nocov:

  before_action -> { doorkeeper_authorize! :deposit, :cash_desk }

  def create
    deposit = Deposit.new
    consume!(deposit)

    result = UserDeposit.call(
      user_id: params[:user_id],
      amount: deposit.amount,
      requesting_application: doorkeeper_token.application
    )

    if result.success?
      render json: result.transaction, status: :created
    else
      if result.message == 'generic.not_found'
        head :not_found
      else
        head :internal_server_error
      end
    end
  end
end
