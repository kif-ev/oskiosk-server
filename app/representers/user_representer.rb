class UserRepresenter < ApplicationDecorator
  property :type, getter: ->(_) {'user'}, writeable: false
  property :id, writeable: false, type: Integer
  property :name
  property :balance, writeable: false, type: Integer
  property :allow_negative_balance, type: Virtus::Attribute::Boolean
  collection(
    :tags,
    decorator: TagRepresenter,
    skip_parse: lambda { |fragment:, **|
      fragment['name'].blank?
    },
    instance: lambda { |fragment:, **|
      ActsAsTaggableOn::Tag.find_or_create_with_like_by_name(fragment['name'])
    }
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
