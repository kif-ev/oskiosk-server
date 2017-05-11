class TransactionItem < ActiveRecord::Base
  belongs_to :money_transaction, class_name: 'Transaction', foreign_key: :transaction_id
  belongs_to :product
end
