class UserDeposit
  include Interactor

  def call
    user = User.find(context.user_id)

    transaction = Transaction.new
    transaction.buyer_name = user.name
    transaction.user = user
    transaction.type = 'user_deposit'
    transaction.total_price = context.amount

    user.balance += context.amount

    user.save
    transaction.save
  end
end
