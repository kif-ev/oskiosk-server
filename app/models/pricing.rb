class Pricing < ActiveRecord::Base
  belongs_to :product
  has_many :cart_items

  validates :quantity, numericality: { only_integer: true }
  validates :price, numericality: { only_integer: true }

  def available_quantity
    quantity - cart_items.unexpired.sum(:quantity)
  end
end
