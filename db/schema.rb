# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2024_11_11_055641) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "bussiness_hours", force: :cascade do |t|
    t.string "day_of_week"
    t.time "opening_hour"
    t.time "closing_hour"
    t.integer "restaurant_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_open", default: false, null: false
    t.index ["restaurant_id"], name: "index_bussiness_hours_on_restaurant_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "name"
    t.string "cpf"
    t.string "phone_number"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "restaurant_id", null: false
    t.index ["restaurant_id"], name: "index_customers_on_restaurant_id"
  end

  create_table "employees", force: :cascade do |t|
    t.string "email"
    t.string "cpf"
    t.boolean "is_registered"
    t.integer "restaurant_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["restaurant_id"], name: "index_employees_on_restaurant_id"
  end

  create_table "item_options", force: :cascade do |t|
    t.string "description"
    t.decimal "price"
    t.integer "item_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_item_options_on_item_id"
  end

  create_table "item_tags", force: :cascade do |t|
    t.integer "item_id", null: false
    t.integer "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_item_tags_on_item_id"
    t.index ["tag_id"], name: "index_item_tags_on_tag_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "type"
    t.string "name"
    t.string "description"
    t.integer "calories"
    t.boolean "alcoholic"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "restaurant_id", null: false
    t.boolean "is_active", default: true, null: false
    t.index ["restaurant_id"], name: "index_items_on_restaurant_id"
  end

  create_table "menu_items", force: :cascade do |t|
    t.integer "menu_id", null: false
    t.integer "item_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_menu_items_on_item_id"
    t.index ["menu_id"], name: "index_menu_items_on_menu_id"
  end

  create_table "menus", force: :cascade do |t|
    t.string "name"
    t.integer "restaurant_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["restaurant_id"], name: "index_menus_on_restaurant_id"
  end

  create_table "option_historicals", force: :cascade do |t|
    t.decimal "historical_price"
    t.datetime "price_changed_at"
    t.integer "item_option_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_option_id"], name: "index_option_historicals_on_item_option_id"
  end

  create_table "order_items", force: :cascade do |t|
    t.integer "order_id", null: false
    t.integer "item_option_id", null: false
    t.string "observation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "price_at_order"
    t.index ["item_option_id"], name: "index_order_items_on_item_option_id"
    t.index ["order_id"], name: "index_order_items_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "customer_id", null: false
    t.decimal "total"
    t.integer "status", default: 0
    t.string "code"
    t.datetime "order_date"
    t.integer "restaurant_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_orders_on_customer_id"
    t.index ["restaurant_id"], name: "index_orders_on_restaurant_id"
  end

  create_table "restaurants", force: :cascade do |t|
    t.string "corporate_name"
    t.string "brand_name"
    t.string "cnpj"
    t.string "full_address"
    t.string "phone_number"
    t.string "email"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.integer "restaurant_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["restaurant_id"], name: "index_tags_on_restaurant_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.string "last_name"
    t.string "cpf"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "restaurant_id"
    t.integer "role", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["restaurant_id"], name: "index_users_on_restaurant_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "bussiness_hours", "restaurants"
  add_foreign_key "customers", "restaurants"
  add_foreign_key "employees", "restaurants"
  add_foreign_key "item_options", "items"
  add_foreign_key "item_tags", "items"
  add_foreign_key "item_tags", "tags"
  add_foreign_key "items", "restaurants"
  add_foreign_key "menu_items", "items"
  add_foreign_key "menu_items", "menus"
  add_foreign_key "menus", "restaurants"
  add_foreign_key "option_historicals", "item_options"
  add_foreign_key "order_items", "item_options"
  add_foreign_key "order_items", "orders"
  add_foreign_key "orders", "customers"
  add_foreign_key "orders", "restaurants"
  add_foreign_key "tags", "restaurants"
  add_foreign_key "users", "restaurants"
end
