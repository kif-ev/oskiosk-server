class AddDefaultFalseToUsersAllowNegativeBalance < ActiveRecord::Migration[5.1]
  def up
    change_column :users, :allow_negative_balance, :boolean, default: false
  end

  def down
    change_column :users, :allow_negative_balance, :boolean, default: nil
  end
end
