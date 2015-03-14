class TransactionItem < ActiveRecord::Base
  belongs_to :money_transaction, class_name: Transaction
  belongs_to :product
end
