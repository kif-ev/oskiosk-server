require 'representable/coercion'

module DepositRepresenter
  include Roar::JSON::HAL
  include Representable::Coercion

  property :amount, type: Integer, default: 0
end
