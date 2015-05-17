class AddAllowNegativeBalanceToUsers < ActiveRecord::Migration
  def change
    add_column :users, :allow_negative_balance, :boolean
  end
end
