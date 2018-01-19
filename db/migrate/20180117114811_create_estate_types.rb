class CreateEstateTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :estate_types do |t|
      t.string :name, null: false, index: { unique: true }

      t.timestamps
    end
  end
end
