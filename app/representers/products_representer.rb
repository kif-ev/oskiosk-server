require 'roar/json/collection'

class ProductsRepresenter < Roar::Decorator
  include Roar::JSON::Collection

  items decorator: ProductRepresenter, class: Product
end

