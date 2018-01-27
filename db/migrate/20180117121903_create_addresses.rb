class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.references :street, null: false, foreign_key: true
      t.string :building_number, index: true, null: false

      t.timestamps
    end
  end
end
