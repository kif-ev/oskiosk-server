module ProductRepresenter
  include Roar::JSON::HAL

  property :type, getter: ->(a) {'product'}
  property :id
  property :name
  property :quantity
  property :available_quantity

  collection :pricings do
    property :id
    property :quantity
    property :available_quantity
    property :price
  end

  link :self do
    product_path(self)
  end
end
