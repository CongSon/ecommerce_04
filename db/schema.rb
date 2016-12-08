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

ActiveRecord::Schema.define(version: 20161205064344) do

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "depth",       default: 0, null: false
    t.integer  "lft",                     null: false
    t.integer  "rgt",                     null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["lft"], name: "index_categories_on_lft"
    t.index ["name"], name: "index_categories_on_name", unique: true
    t.index ["rgt"], name: "index_categories_on_rgt"
  end

  create_table "comments", force: :cascade do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["id", "user_id"], name: "index_comments_on_id_and_user_id", unique: true
    t.index ["product_id"], name: "index_comments_on_product_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "favorites", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_favorites_on_product_id"
    t.index ["user_id", "product_id"], name: "index_favorites_on_user_id_and_product_id", unique: true
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "order_details", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "quantity"
    t.integer  "order_id"
    t.float    "price"
    t.string   "product_name"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["id", "product_id"], name: "index_order_details_on_id_and_product_id", unique: true
    t.index ["order_id"], name: "index_order_details_on_order_id"
    t.index ["product_id"], name: "index_order_details_on_product_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "status"
    t.float    "total_pay"
    t.integer  "user_id"
    t.string   "shipping_address"
    t.string   "phone"
    t.string   "bill_code"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["id", "user_id"], name: "index_orders_on_id_and_user_id", unique: true
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.text     "description", default: ""
    t.float    "price"
    t.string   "image"
    t.integer  "quantity"
    t.float    "rating"
    t.integer  "category_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["category_id"], name: "index_products_on_category_id"
    t.index ["id", "category_id"], name: "index_products_on_id_and_category_id", unique: true
    t.index ["name"], name: "index_products_on_name", unique: true
  end

  create_table "promotions", force: :cascade do |t|
    t.integer  "product_id"
    t.float    "sale"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["id", "product_id"], name: "index_promotions_on_id_and_product_id", unique: true
    t.index ["product_id"], name: "index_promotions_on_product_id"
  end

  create_table "rates", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "product_id"
    t.float    "point"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_rates_on_product_id"
    t.index ["user_id", "product_id"], name: "index_rates_on_user_id_and_product_id", unique: true
    t.index ["user_id"], name: "index_rates_on_user_id"
  end

  create_table "specifications", force: :cascade do |t|
    t.integer  "product_id"
    t.string   "feature_type"
    t.string   "feature_value"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["id", "product_id"], name: "index_specifications_on_id_and_product_id", unique: true
    t.index ["product_id"], name: "index_specifications_on_product_id"
  end

  create_table "suggested_products", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.boolean  "status"
    t.integer  "user_id"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["category_id"], name: "index_suggested_products_on_category_id"
    t.index ["id", "user_id"], name: "index_suggested_products_on_id_and_user_id", unique: true
    t.index ["user_id"], name: "index_suggested_products_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "name"
    t.string   "phone"
    t.boolean  "gender"
    t.string   "avatar"
    t.integer  "role"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
