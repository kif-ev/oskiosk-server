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
    skip_parse: lambda { |fragment:, **|
      fragment['code'].blank?
    },
    instance: lambda { |fragment:, represented:, **|
      code = fragment['code']
      if Identifier.where.not(identifiable: represented).exists?(code: code)
        raise ApplicationController::UnprocessableRequest
      end
      represented.identifiers.find_or_initialize_by(code: code)
    }
  )

  link :self do
    url_for represented
  end
end
