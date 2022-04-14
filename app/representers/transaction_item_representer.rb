class TransactionItemRepresenter < ApplicationDecorator
  property :type, getter: ->(_) {'transaction_item'}, writeable: false
  property :id, writeable: false, type: Representable::Coercion::Types::Params::Integer
  property :product_id, writeable: false, type: Representable::Coercion::Types::Params::Integer
  property :price, writeable: false, type: Representable::Coercion::Types::Params::Integer
  property :name, writeable: false
  property :quantity, writeable: false, type: Representable::Coercion::Types::Params::Integer

  link :product do
    url_for represented.product if represented.product.present?
  end
end
