require 'roar/json/collection'

module TransactionsRepresenter
  include Roar::JSON::HAL
  include Roar::JSON::Collection

  items extend: TransactionRepresenter, class: Product
end
