class PopulateCartPaymentTransaction
  include Interactor

  def call
    context.transaction.transaction_type = 'cart_payment'
    context.transaction.amount = - context.cart.total_price

    context.cart.cart_items.each do |ci|
      context.transaction.transaction_items.build(
        price: ci.unit_price,
        quantity: ci.quantity,
        name: ci.product_name,
        product: ci.product
      )
    end
  end
end
