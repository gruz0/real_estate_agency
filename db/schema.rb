# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_08_27_185429) do

  create_table "addresses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "street_id", null: false
    t.string "building_number", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["building_number"], name: "index_addresses_on_building_number"
    t.index ["street_id"], name: "index_addresses_on_street_id"
  end

  create_table "audits", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "auditable_id"
    t.string "auditable_type"
    t.integer "associated_id"
    t.string "associated_type"
    t.integer "user_id"
    t.string "user_type"
    t.string "username"
    t.string "action"
    t.text "audited_changes"
    t.integer "version", default: 0
    t.string "comment"
    t.string "remote_address"
    t.string "request_uuid"
    t.datetime "created_at"
    t.index ["associated_type", "associated_id"], name: "associated_index"
    t.index ["auditable_type", "auditable_id"], name: "auditable_index"
    t.index ["created_at"], name: "index_audits_on_created_at"
    t.index ["request_uuid"], name: "index_audits_on_request_uuid"
    t.index ["user_id", "user_type"], name: "user_index"
  end

  create_table "cities", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_cities_on_name", unique: true
  end

  create_table "clients", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "full_name", null: false
    t.string "phone_numbers", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["full_name"], name: "index_clients_on_full_name"
    t.index ["phone_numbers"], name: "index_clients_on_phone_numbers"
  end

  create_table "competitors", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name"
    t.string "phone_numbers", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_competitors_on_name"
    t.index ["phone_numbers"], name: "index_competitors_on_phone_numbers"
  end

  create_table "employees", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "last_name", null: false
    t.string "first_name", null: false
    t.string "middle_name"
    t.string "phone_numbers"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.integer "role", limit: 1, default: 0, null: false
    t.index ["email"], name: "index_employees_on_email", unique: true
    t.index ["last_name"], name: "index_employees_on_last_name"
    t.index ["reset_password_token"], name: "index_employees_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_employees_on_unlock_token", unique: true
  end

  create_table "estate_materials", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_estate_materials_on_name", unique: true
  end

  create_table "estate_projects", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_estate_projects_on_name", unique: true
  end

  create_table "estate_types", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_estate_types_on_name", unique: true
  end

  create_table "estates", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "estate_type_id", null: false
    t.bigint "estate_project_id", null: false
    t.bigint "estate_material_id", null: false
    t.bigint "address_id", null: false
    t.bigint "responsible_employee_id", null: false
    t.bigint "created_by_employee_id", null: false
    t.bigint "updated_by_employee_id"
    t.integer "number_of_rooms", limit: 1
    t.integer "floor", limit: 1
    t.integer "number_of_floors", limit: 1
    t.float "total_square_meters"
    t.float "kitchen_square_meters"
    t.text "description"
    t.string "apartment_number"
    t.integer "price", null: false
    t.integer "status", limit: 1, default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "client_full_name", default: "", null: false
    t.string "client_phone_numbers", default: "", null: false
    t.date "delayed_until"
    t.index ["address_id"], name: "index_estates_on_address_id"
    t.index ["created_by_employee_id"], name: "index_estates_on_created_by_employee_id"
    t.index ["estate_material_id"], name: "index_estates_on_estate_material_id"
    t.index ["estate_project_id"], name: "index_estates_on_estate_project_id"
    t.index ["estate_type_id"], name: "index_estates_on_estate_type_id"
    t.index ["price"], name: "index_estates_on_price"
    t.index ["responsible_employee_id"], name: "index_estates_on_responsible_employee_id"
    t.index ["status"], name: "index_estates_on_status"
    t.index ["updated_by_employee_id"], name: "index_estates_on_updated_by_employee_id"
  end

  create_table "streets", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "city_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_streets_on_city_id"
    t.index ["name"], name: "index_streets_on_name"
  end

  add_foreign_key "addresses", "streets"
  add_foreign_key "estates", "addresses"
  add_foreign_key "estates", "employees", column: "created_by_employee_id"
  add_foreign_key "estates", "employees", column: "responsible_employee_id"
  add_foreign_key "estates", "employees", column: "updated_by_employee_id"
  add_foreign_key "estates", "estate_materials"
  add_foreign_key "estates", "estate_projects"
  add_foreign_key "estates", "estate_types"
  add_foreign_key "streets", "cities"
end
