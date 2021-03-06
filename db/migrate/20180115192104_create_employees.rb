# frozen_string_literal: true

class CreateEmployees < ActiveRecord::Migration[5.1]
  def change
    create_table :employees do |t|
      t.string :last_name, null: false, index: true
      t.string :first_name, null: false
      t.string :middle_name
      t.string :phone_numbers

      t.timestamps
    end
  end
end
