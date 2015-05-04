module ProductRepresenter
  include Roar::JSON::HAL

  property :type, getter: ->(_) {'product'}, writeable: false
  property :id, writeable: false, type: Integer
  property :name
  property :quantity, writeable: false, type: Integer
  property :available_quantity, writeable: false, type: Integer
  collection :tag_list, as: :tags

  collection :pricings do
    property :type, getter: ->(_) {'pricing'}, writeable: false
    property :id, type: Integer
    property :quantity, type: Integer
    property :available_quantity, writeable: false, type: Integer
    property :price, type: Integer
  end

  link :self do
    url_for self
  end
end
