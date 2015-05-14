class InitializeTransaction
  include Interactor

  def call
    context.transaction = Transaction.new

    context.transaction.user = context.user
    context.transaction.user_name = context.user.name
  end
end
