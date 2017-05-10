require 'roar/coercion'

class DepositRepresenter < Roar::Decorator
  include Roar::JSON::HAL
  include Roar::Coercion

  property :amount, type: Integer, default: 0
end
