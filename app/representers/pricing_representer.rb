class PricingRepresenter < ApplicationDecorator
  property :type, getter: ->(_) {'pricing'}, writeable: false
  property :id, writeable: false, type: Representable::Coercion::Types::Params::Integer
  property :quantity, type: Representable::Coercion::Types::Params::Integer
  property :available_quantity, writeable: false, type: Representable::Coercion::Types::Params::Integer
  property :price, type: Representable::Coercion::Types::Params::Integer
end
