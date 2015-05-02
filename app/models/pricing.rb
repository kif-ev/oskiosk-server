class Pricing < ActiveRecord::Base
  belongs_to :product
  has_many :cart_items, dependent: :destroy

  def available_quantity
    quantity - cart_items.sum(:quantity)
  end
end
