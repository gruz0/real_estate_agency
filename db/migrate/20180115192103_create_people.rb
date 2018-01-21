class CreatePeople < ActiveRecord::Migration[5.1]
  def change
    create_table :people do |t|
      t.string :type, null: false, index: true
      t.string :last_name, null: false, index: true
      t.string :first_name, null: false
      t.string :middle_name
      t.string :phone_numbers, null: false, index: true
      t.integer :active, null: false, default: 1

      t.timestamps
    end
  end
end
