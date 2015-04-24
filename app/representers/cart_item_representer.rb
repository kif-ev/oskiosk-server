module CartItemRepresenter
  include Roar::JSON::HAL

  property :type, getter: ->(_) {'cart_item'}, writeable: false
  property :pricing_id
  property :quantity
  property :product_name, writeable: false
  property :unit_price, writeable: false
  property :total_price, writeable: false
end
