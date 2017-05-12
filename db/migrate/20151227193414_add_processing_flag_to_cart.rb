class AddProcessingFlagToCart < ActiveRecord::Migration[4.2]
  def change
    add_column :carts, :processing, :boolean
  end
end
