class User < ActiveRecord::Base
  has_many :identifiers, as: :identifiable
  has_many :carts
end
