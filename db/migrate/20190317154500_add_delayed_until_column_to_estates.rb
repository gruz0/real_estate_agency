class AddDelayedUntilColumnToEstates < ActiveRecord::Migration[5.1]
  def self.up
    add_column :estates, :delayed_until, :datetime, null: true
  end

  def self.down
    remove_column :estates, :delayed_until
  end
end
