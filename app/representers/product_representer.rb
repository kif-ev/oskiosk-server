class ProductRepresenter < ApplicationDecorator
  property :type, getter: ->(_) {'product'}, writeable: false
  property :id, writeable: false, type: Integer
  property :name
  property :quantity, writeable: false, type: Integer
  property :available_quantity, writeable: false, type: Integer
  collection :tag_list, as: :tags

  collection(
    :pricings,
    decorator: PricingRepresenter,
    class: Pricing,
    populator: ->(fragment, options) do
      pricings = options[:represented].pricings
      pricing = pricings.find { |p| p.id == fragment['id'] }
      pricing ||= pricings.build
      pricing.quantity = fragment['quantity'] || 0
      pricing.price = fragment['price'] || 0
      pricing
    end
  )

  collection(
    :identifiers,
    decorator: IdentifierRepresenter,
    class: Identifier,
    populator: ->(fragment, options) do
      identifiers = options[:represented].identifiers
      identifier = identifiers.find { |i| i.code == fragment['code'] }
      identifier ||= identifiers.build code: fragment['code']
      identifier
    end
  )

  link :self do
    url_for represented
  end
end
