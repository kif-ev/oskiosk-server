class PayCart
  include Interactor

  def call
    cart = Cart.find(context.cart_id)
    user = cart.user

    transaction = Transaction.new
    transaction.buyer_name = user.name
    transaction.user = user
    transaction.type = 'cart_payment'
    transaction.total_price = cart.cart_items.map(&:total_price).reduce(:+)

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

    user.save
    transaction.save
    cart.destroy
  end
end
