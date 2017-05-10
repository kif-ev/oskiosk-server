require 'roar/coercion'

class CartItemRepresenter < Roar::Decorator
  include Roar::JSON::HAL
  include Roar::Coercion

  property :type, getter: ->(_) {'cart_item'}, writeable: false
  property :pricing_id, type: Integer
  property :quantity, type: Integer
  property :product_name, writeable: false
  property :unit_price, writeable: false, type: Integer
  property :total_price, writeable: false, type: Integer
end
