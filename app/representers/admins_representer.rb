class AdminsRepresenter < CollectionDecorator
  items decorator: AdminRepresenter, class: Admin
end
