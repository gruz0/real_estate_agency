class CreateEstates < ActiveRecord::Migration[5.1]
  def change
    create_table :estates do |t|
      t.integer :deal_type, null: false, index: true, limit: 1, default: 1

      # Квартира, дом, комната, нежилое помещение
      t.references :estate_type, null: false, foreign_key: true

      # Уральский, ленинградский, саратовский, ...
      t.references :estate_project, null: false, foreign_key: true

      # Панельный, заливной, блочный, кирпичный, ...
      t.references :estate_material, null: false, foreign_key: true

      t.references :address, null: false, foreign_key: true
      t.references :client, null: false, foreign_key: true
      t.references :responsible_employee, null: false, foreign_key: { to_table: :employees }
      t.references :created_by_employee, null: false, foreign_key: { to_table: :employees }
      t.references :updated_by_employee, foreign_key: { to_table: :employees }

      t.integer :number_of_rooms, limit: 1
      t.integer :floor, limit: 1
      t.integer :number_of_floors, limit: 1
      t.float :total_square_meters
      t.float :kitchen_square_meters
      t.string :description
      t.string :apartment_number
      t.decimal :price, null: false, index: true, precision: 12, scale: 2
      t.integer :status, null: false, index: true, limit: 1, default: 1

      t.timestamps
    end
  end
end
