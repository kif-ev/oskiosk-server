class UserRepresenter < ApplicationDecorator
  property :type, getter: ->(_) {'user'}, writeable: false
  property :id, writeable: false, type: Integer
  property :name
  property :balance, writeable: false, type: Integer
  collection :tag_list, as: :tags

  link :self do
    url_for represented
  end
end
