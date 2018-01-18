class CreateStreets < ActiveRecord::Migration[5.1]
  def change
    create_table :streets do |t|
      t.string :name, null: false, index: { unique: true }
      t.references :city, null: false, foreign_key: true

      t.timestamps
    end
  end
end
