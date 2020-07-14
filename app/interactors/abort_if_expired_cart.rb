class AbortIfExpiredCart
  include Interactor

  def call
    context.fail!(message: 'generic.not_found') if context.cart.expired?
  end
end
