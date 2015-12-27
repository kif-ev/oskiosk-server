class AddOptimisticLockingToCarts < ActiveRecord::Migration
  def change
    add_column :carts, :lock_version, :integer
  end
end
