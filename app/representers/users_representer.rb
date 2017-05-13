class UsersRepresenter < CollectionDecorator
  items decorator: UserRepresenter, class: User
end
