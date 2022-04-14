class IdentifierRepresenter < ApplicationDecorator
  property :code, type: Representable::Coercion::Types::Params::String
end
