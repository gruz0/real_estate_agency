# frozen_string_literal: true

class CreateEstateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :estate_projects do |t|
      t.string :name, null: false, index: { unique: true }

      t.timestamps
    end
  end
end
