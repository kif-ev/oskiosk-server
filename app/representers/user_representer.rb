class UserRepresenter < ApplicationDecorator
  property :type, getter: ->(_) {'user'}, writeable: false
  property :id, writeable: false, type: Integer
  property :name
  property :balance, writeable: false, type: Integer
  property :allow_negative_balance, type: Virtus::Attribute::Boolean
  collection :tag_list, as: :tags

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
