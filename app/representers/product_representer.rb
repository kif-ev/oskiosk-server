module ProductRepresenter
  include Roar::JSON::HAL

  property :type, getter: ->(_) {'product'}, writeable: false
  property :id, writeable: false
  property :name
  property :quantity
  property :available_quantity, writeable: false

  collection :pricings do
    property :type, getter: ->(_) {'pricing'}, writeable: false
    property :id
    property :quantity
    property :available_quantity, writeable: false
    property :price
  end

  link :self do
    url_for self
  end
end
