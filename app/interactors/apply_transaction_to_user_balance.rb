class ApplyTransactionToUserBalance
  include Interactor

  def call
    context.user.balance += context.transaction.amount
    begin
      context.user.save!
    rescue
      context.fail!(message: 'generic.write_failed')
    end
  end

  def rollback
    context.user.balance -= context.transaction.amount
    context.user.save!
  end
end
