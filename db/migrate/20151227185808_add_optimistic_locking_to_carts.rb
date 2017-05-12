class AddOptimisticLockingToCarts < ActiveRecord::Migration[4.2]
  def change
    add_column :carts, :lock_version, :integer
  end
end
