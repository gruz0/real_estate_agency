# frozen_string_literal: true

class CreateCompetitors < ActiveRecord::Migration[5.1]
  def change
    create_table :competitors do |t|
      t.string :name, null: true, index: true
      t.string :phone_numbers, null: false, index: true

      t.timestamps
    end
  end
end
