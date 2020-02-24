# frozen_string_literal: true

class UpdateEstateClientColumns < ActiveRecord::Migration[5.1]
  def self.up
    remove_reference :estates, :client, foreign_key: true

    add_column :estates, :client_full_name, :string, null: false, default: ''
    add_column :estates, :client_phone_numbers, :string, null: false, default: ''
  end

  def self.down
    add_reference :estates, :client, foreign_key: true

    remove_column :estates, :client_full_name
    remove_column :estates, :client_phone_numbers
  end
end
