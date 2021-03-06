class FixTransactionColumnNames < ActiveRecord::Migration[4.2]
  def change
    rename_column :transactions, :type, :transaction_type
    rename_column :transactions, :buyer_name, :user_name
    rename_column :transactions, :total_price, :amount
  end
end
