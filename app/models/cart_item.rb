class CartItem < ActiveRecord::Base
  belongs_to :cart
  belongs_to :pricing
  has_one :product, through: :pricing

  def product_name
    product.try(:name) || ''
  end

  def unit_price
    pricing.try(:price) || 0
  end

  def total_price
    unit_price * quantity
  end
end
