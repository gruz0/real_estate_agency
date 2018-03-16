class CreateLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :logs do |t|
      t.integer :employee_id, null: false
      t.string :controller, null: true, default: ''
      t.string :action, null: true, default: ''
      t.text :params, null: true, default: ''
      t.integer :entity_id, null: true, default: ''
      t.text :error_messages, null: true, default: ''
      t.text :flash_notice, null: true, default: ''
      t.datetime :created_at, null: false, default: Time.zone.now
    end
  end
end
