module UserRepresenter
  include Roar::JSON::HAL

  property :type, getter: ->(_) {'user'}, writeable: false
  property :id, writeable: false, type: Integer
  property :name
  property :balance, writeable: false, type: Integer

  link :self do
    url_for self
  end
end
