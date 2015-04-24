module CartRepresenter
  include Roar::JSON::HAL

  property :type, getter: ->(_) {'cart'}, writeable: false
  property :id, writeable: false
  property :user_id

  collection(
    :cart_items,
    extend: CartItemRepresenter,
    class: CartItem,
    parse_strategy: lambda do |fragment, _, _|
      cart_item = cart_items.where(pricing_id: fragment['pricing_id']).
                  first_or_initialize
      cart_item.quantity = fragment['quantity']
      cart_items << cart_item
      cart_item
    end
  )

  link :self do
    cart_path(self)
  end
end
