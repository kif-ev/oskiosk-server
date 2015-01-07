require 'roar/json/collection'

module ProductsRepresenter
  include Roar::JSON::HAL
  include Roar::JSON::Collection

  items extend: ProductRepresenter, class: Product
end

