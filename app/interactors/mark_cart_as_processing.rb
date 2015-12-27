class MarkCartAsProcessing
  include Interactor

  def call
    if context.cart.processing?
      context.fail!(message: 'generic.processing')
    else
      begin
        context.cart.update(
          processing: true,
          lock_version: context.cart_version
        )
      rescue ActiveRecord::StaleObjectError
        context.fail!(message: 'generic.stale')
      end
    end
  end
end
