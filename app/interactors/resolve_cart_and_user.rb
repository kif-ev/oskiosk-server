class ResolveCartAndUser
  include Interactor

  def call
    begin
      context.cart = Cart.find_by_id!(context.cart_id)
    rescue ActiveRecord::RecordNotFound
      context.fail!(message: 'generic.not_found')
    end

    context.user = context.cart.user
  end
end
