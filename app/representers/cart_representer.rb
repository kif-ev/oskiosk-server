module CartRepresenter
  include Roar::JSON::HAL

  property :id
  property :user_id

  collection :cart_items, class: CartItem do
    property :pricing_id
    property :quantity
  end

  link :self do
    cart_path(self)
  end
end
