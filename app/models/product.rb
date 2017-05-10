class Product < ActiveRecord::Base
  acts_as_taggable

  has_many :identifiers, as: :identifiable, autosave: true
  has_many :pricings, dependent: :destroy, autosave: true

  def quantity
    pricings.sum :quantity
  end

  def available_quantity
    pricings.to_a.sum &:available_quantity
  end
end
