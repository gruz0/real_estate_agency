# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180209112811) do

  create_table "addresses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "street_id", null: false
    t.string "building_number", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["building_number"], name: "index_addresses_on_building_number"
    t.index ["street_id"], name: "index_addresses_on_street_id"
  end

  create_table "cities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_cities_on_name", unique: true
  end

  create_table "clients", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "full_name", null: false
    t.string "phone_numbers", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["full_name"], name: "index_clients_on_full_name"
    t.index ["phone_numbers"], name: "index_clients_on_phone_numbers"
  end

  create_table "competitors", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "phone_numbers", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_competitors_on_name"
    t.index ["phone_numbers"], name: "index_competitors_on_phone_numbers"
  end

  create_table "employees", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "last_name", null: false
    t.string "first_name", null: false
    t.string "middle_name"
    t.string "phone_numbers"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["last_name"], name: "index_employees_on_last_name"
  end

  create_table "estate_materials", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_estate_materials_on_name", unique: true
  end

  create_table "estate_projects", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_estate_projects_on_name", unique: true
  end

  create_table "estate_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_estate_types_on_name", unique: true
  end

  create_table "estates", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "estate_type_id", null: false
    t.bigint "estate_project_id", null: false
    t.bigint "estate_material_id", null: false
    t.bigint "address_id", null: false
    t.bigint "client_id", null: false
    t.bigint "responsible_employee_id", null: false
    t.bigint "created_by_employee_id", null: false
    t.bigint "updated_by_employee_id"
    t.integer "number_of_rooms", limit: 1
    t.integer "floor", limit: 1
    t.integer "number_of_floors", limit: 1
    t.float "total_square_meters", limit: 24
    t.float "kitchen_square_meters", limit: 24
    t.text "description"
    t.string "apartment_number"
    t.integer "price", null: false
    t.integer "status", limit: 1, default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["address_id"], name: "index_estates_on_address_id"
    t.index ["client_id"], name: "index_estates_on_client_id"
    t.index ["created_by_employee_id"], name: "index_estates_on_created_by_employee_id"
    t.index ["estate_material_id"], name: "index_estates_on_estate_material_id"
    t.index ["estate_project_id"], name: "index_estates_on_estate_project_id"
    t.index ["estate_type_id"], name: "index_estates_on_estate_type_id"
    t.index ["price"], name: "index_estates_on_price"
    t.index ["responsible_employee_id"], name: "index_estates_on_responsible_employee_id"
    t.index ["status"], name: "index_estates_on_status"
    t.index ["updated_by_employee_id"], name: "index_estates_on_updated_by_employee_id"
  end

  create_table "streets", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", null: false
    t.bigint "city_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_streets_on_city_id"
    t.index ["name"], name: "index_streets_on_name", unique: true
  end

  add_foreign_key "addresses", "streets"
  add_foreign_key "estates", "addresses"
  add_foreign_key "estates", "clients"
  add_foreign_key "estates", "employees", column: "created_by_employee_id"
  add_foreign_key "estates", "employees", column: "responsible_employee_id"
  add_foreign_key "estates", "employees", column: "updated_by_employee_id"
  add_foreign_key "estates", "estate_materials"
  add_foreign_key "estates", "estate_projects"
  add_foreign_key "estates", "estate_types"
  add_foreign_key "streets", "cities"
end
