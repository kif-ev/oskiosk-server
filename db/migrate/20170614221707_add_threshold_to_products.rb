class AddThresholdToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :warning_threshold, :integer
  end
end
