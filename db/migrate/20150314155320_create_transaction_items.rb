class CreateTransactionItems < ActiveRecord::Migration
  def change
    create_table :transaction_items do |t|
      t.references :transaction, index: true
      t.references :product, index: true
      t.integer :price
      t.string :name
      t.integer :quantity

      t.timestamps null: false
    end
    add_foreign_key :transaction_items, :transactions
    add_foreign_key :transaction_items, :products
  end
end
