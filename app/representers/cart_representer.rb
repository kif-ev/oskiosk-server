class CartRepresenter < ApplicationDecorator
  property :type, getter: ->(_) {'cart'}, writeable: false
  property :id, writeable: false, type: Integer
  property :lock_version, type: Integer
  property :user_id, type: Integer
  property :total_price, writeable: false, type: Integer

  collection(
    :cart_items,
    decorator: CartItemRepresenter,
    class: CartItem,
    populator: lambda do |fragment, options|
      cart_items = options[:represented].cart_items
      cart_item = cart_items.find { |ci| ci.pricing_id == fragment['pricing_id'] }
      cart_item ||= cart_items.build pricing_id: fragment['pricing_id']
      cart_item.quantity = fragment['quantity']
      cart_item
    end
  )

  link :self do
    url_for represented
  end
  link :customer do
    url_for represented.user if represented.user.present?
  end
end
