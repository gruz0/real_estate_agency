class AddRoleToEmployees < ActiveRecord::Migration[5.1]
  def self.up
    change_table :employees do |t|
      t.integer :role, null: false, limit: 1, default: 0
    end
  end
end
