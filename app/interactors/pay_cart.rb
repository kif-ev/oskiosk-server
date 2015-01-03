class PayCart
  include Interactor

  def call
    cart = Cart.find(context.cart_id)
    user = cart.user
    cart.cart_items.each do |ci|
      ci.pricing.quantity -= ci.quantity
      ci.pricing.save
      user.balance -= ci.quantity * ci.pricing.price
    end
    user.save
  end
end
