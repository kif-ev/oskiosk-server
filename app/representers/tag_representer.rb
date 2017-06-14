class TagRepresenter < ApplicationDecorator
  property :type, getter: ->(_) { 'tag' }, writeable: false
  property :name, writeable: false
  property :taggings_count, as: :occurrences, writeable: false
end
