require 'roar/coercion'

class ApplicationDecorator < Roar::Decorator
  include Roar::JSON::HAL
  include Roar::Coercion
end
