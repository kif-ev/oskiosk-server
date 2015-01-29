module UserRepresenter
  include Roar::JSON::HAL

  property :type, getter: ->(a) {'user'}, writeable: false
  property :id, writeable: false
  property :name

  link :self do
    user_path(self)
  end
end
