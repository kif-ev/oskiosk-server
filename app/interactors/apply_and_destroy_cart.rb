class ApplyAndDestroyCart
  include Interactor

  def call
    ActiveRecord::Base.transaction do
      context.cart.cart_items.each do |ci|
        ci.pricing.quantity -= ci.quantity
        ci.pricing.save!
      end

      context.cart.destroy!
    end
  rescue
    context.fail!(message: 'generic.write_failed')
  end
end
