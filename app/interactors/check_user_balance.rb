class CheckUserBalance
  include Interactor

  def call
    return if context.user.allow_negative_balance?
    if (context.user.balance + context.transaction.amount) < 0
      context.fail!(message: 'user.balance_exceeded')
    end
  end
end
