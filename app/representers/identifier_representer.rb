require 'roar/coercion'

class IdentifierRepresenter < Roar::Decorator
  include Roar::JSON::HAL
  include Roar::Coercion

  property :code, type: String
end
