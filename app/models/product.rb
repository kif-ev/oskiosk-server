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

  def below_warning_threshold?
    return false if warning_threshold.nil?
    quantity <= warning_threshold
  end
end
