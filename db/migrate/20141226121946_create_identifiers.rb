class CreateIdentifiers < ActiveRecord::Migration[4.2]
  def change
    create_table :identifiers do |t|
      t.string :code, index: true
      t.references :identifiable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
