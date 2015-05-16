class User < ActiveRecord::Base
  acts_as_taggable

  has_many :identifiers, as: :identifiable
  has_many :carts
end
