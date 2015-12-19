require 'roar/json/collection'

module TransactionsRepresenter
  include Roar::JSON::Collection

  items extend: TransactionRepresenter, class: Transaction
end
