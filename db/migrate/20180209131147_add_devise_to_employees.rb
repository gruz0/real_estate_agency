class AddDeviseToEmployees < ActiveRecord::Migration[5.1]
  def self.up
    change_table :employees, bulk: true do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ''
      t.string :encrypted_password, null: false, default: ''

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Lockable
      t.integer  :failed_attempts, default: 0, null: false
      t.string   :unlock_token
      t.datetime :locked_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip
    end

    add_index :employees, :email,                unique: true
    add_index :employees, :reset_password_token, unique: true
    add_index :employees, :unlock_token,         unique: true
  end

  def self.down
    # By default, we don't want to make any assumption about how to roll back a migration when your
    # model already existed. Please edit below which fields you would like to remove in this migration.
    raise ActiveRecord::IrreversibleMigration
  end
end
