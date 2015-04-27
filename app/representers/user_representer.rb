module UserRepresenter
  include Roar::JSON::HAL

  property :type, getter: ->(_) {'user'}, writeable: false
  property :id, writeable: false
  property :name

  link :self do
    url_for self
  end
end
