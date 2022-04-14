class CartItemRepresenter < ApplicationDecorator
  property :type, getter: ->(_) {'cart_item'}, writeable: false
  property :pricing_id, type: Representable::Coercion::Types::Params::Integer
  property :quantity, type: Representable::Coercion::Types::Params::Integer
  property :product_name, writeable: false
  property :unit_price, writeable: false, type: Representable::Coercion::Types::Params::Integer
  property :total_price, writeable: false, type: Representable::Coercion::Types::Params::Integer
end
