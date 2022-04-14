class ProductRepresenter < ApplicationDecorator
  property :type, getter: ->(_) {'product'}, writeable: false
  property :id, writeable: false, type: Representable::Coercion::Types::Params::Integer
  property :name
  property :quantity, writeable: false, type: Representable::Coercion::Types::Params::Integer
  property :available_quantity, writeable: false, type: Representable::Coercion::Types::Params::Integer
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
    :pricings,
    decorator: PricingRepresenter,
    instance: lambda { |fragment:, represented:, **|
      if (id = fragment['id'].try(:to_i)).present?
        represented.pricings.find_by(id: id) ||
          raise(ApplicationController::UnprocessableRequest)
      else
        represented.pricings.new
      end
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
