class PopulateUserDepositTransaction
  include Interactor

  def call
    context.transaction.transaction_type = 'user_deposit'
    context.transaction.amount = context.amount
  end
end
