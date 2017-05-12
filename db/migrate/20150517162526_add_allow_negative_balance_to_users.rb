class AddAllowNegativeBalanceToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :allow_negative_balance, :boolean
  end
end
