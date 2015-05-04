class PayCart
  include Interactor

  def call
    begin
      cart = Cart.find_by_id(context.cart_id)
    rescue ActiveRecord::RecordNotFound
      context.fail!(message: 'pay_cart.not_found') rescue false
      return
    end

    user = cart.user

    transaction = Transaction.new
    transaction.user_name = user.name
    transaction.user = user
    transaction.transaction_type = 'cart_payment'
    transaction.amount = cart.cart_items.map(&:total_price).reduce(:+)

    cart.cart_items.each do |ci|
      ci.pricing.quantity -= ci.quantity
      ci.pricing.save

      user.balance -= ci.total_price

      transaction.transaction_items << TransactionItem.new(
        price: ci.unit_price,
        quantity: ci.quantity,
        name: ci.product_name,
        product: ci.product
      )
    end

    begin
      ActiveRecord::Base.transaction do
        user.save!
        transaction.save!
        cart.destroy!
      end
    rescue
      context.fail!(message: 'pay_cart.write_failed') rescue false
      return
    end

    context.transaction = transaction
  end
end
