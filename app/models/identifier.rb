class Identifier < ActiveRecord::Base
  belongs_to :identifiable, polymorphic: true

  validates :code, uniqueness: true
end
