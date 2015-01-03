class CreatePricings < ActiveRecord::Migration
  def change
    create_table :pricings do |t|
      t.integer :price, default: 0
      t.integer :quantity, default: 0
      t.references :product, index: true

      t.timestamps
    end
  end
end
