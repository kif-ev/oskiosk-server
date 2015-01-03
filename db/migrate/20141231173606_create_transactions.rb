class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :total_price, default: 0
      t.string :buyer_name
      t.references :user, index: true

      t.timestamps
    end
  end
end
