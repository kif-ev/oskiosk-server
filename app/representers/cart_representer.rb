module CartRepresenter
  include Roar::JSON::HAL

  property :type, getter: ->(_) {'cart'}, writeable: false
  property :id, writeable: false
  property :user_id

  collection :cart_items, extend: CartItemRepresenter, class: CartItem

  link :self do
    cart_path(self)
  end
end
