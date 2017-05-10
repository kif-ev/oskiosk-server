require 'roar/json/collection'

class UsersRepresenter < Roar::Decorator
  include Roar::JSON::Collection

  items decorator: UserRepresenter, class: User
end
