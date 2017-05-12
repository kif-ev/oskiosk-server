class CreateCarts < ActiveRecord::Migration[4.2]
  def change
    create_table :carts do |t|
      t.references :user

      t.timestamps
    end
  end
end
