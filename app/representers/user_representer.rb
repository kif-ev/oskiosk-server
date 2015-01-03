module UserRepresenter
  include Roar::JSON::HAL

  property :type, getter: ->(a) {'user'}
  property :id
  property :name

  link :self do
    user_path(self)
  end
end
