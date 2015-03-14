class AddTypeToTransaction < ActiveRecord::Migration
  def change
    add_column :transactions, :type, :string
  end
end
