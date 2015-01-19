class Product < ActiveRecord::Base
  has_many :identifiers, as: :identifiable
  has_many :pricings

  def quantity
    pricings.sum :quantity
  end

  def available_quantity
    pricings.to_a.sum &:available_quantity
  end
end
