class Cart < ActiveRecord::Base
  EXPIRE_AFTER = 300 # seconds

  belongs_to :user
  has_many :cart_items, dependent: :destroy, autosave: true

  validate :ensure_unexpired

  scope :unexpired, -> { where unexpired_condition }

  def self.unexpired_condition
    arel_table[:updated_at].gteq(EXPIRE_AFTER.seconds.ago)
  end

  def total_price
    cart_items.map(&:total_price).reduce(:+)
  end

  def expires_at
    (updated_at || DateTime.current) + EXPIRE_AFTER.seconds
  end

  def expired?
    DateTime.current > expires_at
  end

  private

  def ensure_unexpired
    if expired?
      errors.add :expires_at, "can't be in the past"
    end
  end
end
