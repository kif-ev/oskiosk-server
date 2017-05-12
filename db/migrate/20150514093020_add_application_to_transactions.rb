class AddApplicationToTransactions < ActiveRecord::Migration[4.2]
  def change
    change_table :transactions do |t|
      t.string :application_name
      t.references :application
    end
  end
end
