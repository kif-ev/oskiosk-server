class DepositRepresenter < ApplicationDecorator
  property :amount, type: Representable::Coercion::Types::Params::Integer, default: 0
end
