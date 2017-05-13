class TransactionsRepresenter < CollectionDecorator
  items decorator: TransactionRepresenter, class: Transaction
end
