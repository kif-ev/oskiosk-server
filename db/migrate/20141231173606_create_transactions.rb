class CreateTransactions < ActiveRecord::Migration[4.2]
  def change
    create_table :transactions do |t|
      t.integer :total_price, default: 0
      t.string :buyer_name
      t.references :user, index: true

      t.timestamps
    end
  end
end
