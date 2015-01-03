class Identifier < ActiveRecord::Base
  belongs_to :identifiable, polymorphic: true
end
