class CartItem < ActiveRecord::Base
  belongs_to :cart
  belongs_to :pricing
  has_one :product, through: :pricing

  validate :enough_items_present_in_pricing

  scope :unexpired, -> { joins(:cart).where(Cart.unexpired_condition) }

  def product_name
    product.try(:name) || ''
  end

  def unit_price
    pricing.try(:price) || 0
  end

  def total_price
    unit_price * quantity
  end

  private

  def enough_items_present_in_pricing
    if quantity_changed? && pricing.present?
      diff = pricing.available_quantity +
             (quantity_change[0] - quantity_change[1])
      if diff < 0
        self.quantity = self.quantity + diff
        errors.add :quantity, 'can\'t be greater than available items, we \
                               have corrected that for you.'
      end
    end
  end
end
