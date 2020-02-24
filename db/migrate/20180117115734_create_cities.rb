# frozen_string_literal: true

class CreateCities < ActiveRecord::Migration[5.1]
  def change
    create_table :cities do |t|
      t.string :name, null: false, index: { unique: true }

      t.timestamps
    end
  end
end
