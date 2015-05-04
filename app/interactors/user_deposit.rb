class UserDeposit
  include Interactor

  def call
    begin
      user = User.find_by_id(context.user_id)
    rescue ActiveRecord::RecordNotFound
      context.fail!(message: 'user_deposit.not_found') rescue false
      return
    end

    transaction = Transaction.new
    transaction.user_name = user.name
    transaction.user = user
    transaction.transaction_type = 'user_deposit'
    transaction.amount = context.amount

    user.balance += context.amount

    begin
      ActiveRecord::Base.transaction do
        user.save!
        transaction.save!
      end
    rescue
      context.fail!(message: 'user_deposit.write_failed') rescue false
      return
    end

    context.transaction = transaction
  end
end
