require 'roar/json/collection'

module ProductsRepresenter
  include Roar::JSON::Collection

  items extend: ProductRepresenter, class: Product
end

