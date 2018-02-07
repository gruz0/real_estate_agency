class CreateClients < ActiveRecord::Migration[5.1]
  def change
    create_table :clients do |t|
      t.string :full_name, null: false, index: true
      t.string :phone_numbers, null: false, index: true

      t.timestamps
    end
  end
end
