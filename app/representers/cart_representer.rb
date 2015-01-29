module CartRepresenter
  include Roar::JSON::HAL

  property :id
  property :user_id

  collection :cart_items, class: CartItem do
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
