module PricingRepresenter
  include Roar::JSON::HAL

  property :type, getter: ->(_) {'pricing'}, writeable: false
  property :id, writeable: false, type: Integer
  property :quantity, type: Integer
  property :available_quantity, writeable: false, type: Integer
  property :price, type: Integer
end
