require 'roar/json/collection'

module UsersRepresenter
  include Roar::JSON::Collection

  items extend: UserRepresenter, class: User
end
