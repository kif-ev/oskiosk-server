class AddProcessingFlagToCart < ActiveRecord::Migration
  def change
    add_column :carts, :processing, :boolean
  end
end
