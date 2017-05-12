class AddTypeToTransaction < ActiveRecord::Migration[4.2]
  def change
    add_column :transactions, :type, :string
  end
end
