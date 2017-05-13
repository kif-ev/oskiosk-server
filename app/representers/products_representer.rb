class ProductsRepresenter < CollectionDecorator
  items decorator: ProductRepresenter, class: Product
end

