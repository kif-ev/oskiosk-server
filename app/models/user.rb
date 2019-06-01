class User < ActiveRecord::Base
  acts_as_taggable

  has_many :identifiers, as: :identifiable, dependent: :destroy
  has_many :carts
end
