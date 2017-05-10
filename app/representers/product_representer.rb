module ProductRepresenter
  include Roar::JSON::HAL

  property :type, getter: ->(_) {'product'}, writeable: false
  property :id, writeable: false, type: Integer
  property :name
  property :quantity, writeable: false, type: Integer
  property :available_quantity, writeable: false, type: Integer
  collection :tag_list, as: :tags

  collection(
    :pricings,
    extend: PricingRepresenter,
    class: Pricing,
    parse_strategy: ->(fragment, _, _) do
      pricing = pricings.find { |p| p.id == fragment['id'] }
      pricing ||= pricings.build
      pricing.quantity = fragment['quantity'] || 0
      pricing.price = fragment['price'] || 0
      pricing
    end
  )

  collection(
    :identifiers,
    extend: IdentifierRepresenter,
    class: Identifier,
    parse_strategy: ->(fragment, _, _) do
      identifier = identifiers.find { |i| i.code == fragment['code'] }
      identifier ||= identifiers.build code: fragment['code']
      identifier
    end
  )

  link :self do
    url_for self
  end
end
