class TransactionRepresenter < ApplicationDecorator
  property :type, getter: ->(_) {'transaction'}, writeable: false
  property :transaction_type, writeable: false
  property :id, writeable: false, type: Integer
  property :user_name, writeable: false
  property :user_id, writeable: false, type: Integer
  property :amount, writeable: false, type: Integer
  property :created_at, writeable: false, type: DateTime
  collection(
    :transaction_items,
    writeable: false,
    decorator: TransactionItemRepresenter
  )

  link :self do
    url_for represented
  end
  link :user do
    url_for represented.user if represented.user.present?
  end
end
