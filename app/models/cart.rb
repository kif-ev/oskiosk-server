class Cart < ActiveRecord::Base
  belongs_to :user
  has_many :cart_items, dependent: :destroy, autosave: true

  def total_price
    cart_items.map(&:total_price).reduce(:+) || 0
  end
end
