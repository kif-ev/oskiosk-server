class Product < ActiveRecord::Base
  has_many :identifiers, as: :identifiable
  has_many :pricings

  def quantity
    pricings.sum :quantity
  end
end
