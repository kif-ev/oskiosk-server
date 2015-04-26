module CartRepresenter
  include Roar::JSON::HAL

  property :type, getter: ->(_) {'cart'}, writeable: false
  property :id, writeable: false
  property :user_id

  collection :cart_items, class: CartItem do
    property :type, getter: ->(a) {'cart_item'}, writeable: false
    property :pricing_id
    property :quantity
    property :product_name, writeable: false
    property :unit_price, writeable: false
    property :total_price, writeable: false
  end

  link :self do
    cart_path(self)
  end
end
