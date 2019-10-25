class AdminRepresenter < ApplicationDecorator
  property :type, getter: ->(_) {'admin'}, writeable: false
  property :id, writeable: false, type: Integer
  property :email
  property :password, readable: false

  link :self do
    url_for represented
  end
end
