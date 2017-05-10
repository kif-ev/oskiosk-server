module CartRepresenter
  include Roar::JSON::HAL

  property :type, getter: ->(_) {'cart'}, writeable: false
  property :id, writeable: false, type: Integer
  property :lock_version, type: Integer
  property :user_id, type: Integer
  property :total_price, writeable: false, type: Integer

  collection(
    :cart_items,
    extend: CartItemRepresenter,
    class: CartItem,
    parse_strategy: lambda do |fragment, _, _|
      cart_item = cart_items.find { |ci| ci.pricing_id == fragment['pricing_id'] }
      cart_item ||= cart_items.build pricing_id: fragment['pricing_id']
      cart_item.quantity = fragment['quantity']
      cart_item
    end
  )

  link :self do
    url_for self
  end
  link :customer do
    url_for user if user.present?
  end
end
