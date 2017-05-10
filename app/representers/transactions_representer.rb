require 'roar/json/collection'

class TransactionsRepresenter < Roar::Decorator
  include Roar::JSON::Collection

  items decorator: TransactionRepresenter, class: Transaction
end
