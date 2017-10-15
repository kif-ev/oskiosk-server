class WarnIfProductQuantityBelowThreshold
  include Interactor

  def call
    btp = context.cart.cart_items.map(&:product).
          select(&:below_warning_threshold?).
          compact.uniq
    AdminMailer.btp_mail(btp: btp).deliver_later if btp.present?
  end
end
