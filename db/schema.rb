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

ActiveRecord::Schema.define(version: 2020_04_07_091408) do

  create_table "addresses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "post_code", null: false
    t.string "prefecture", null: false
    t.string "city", null: false
    t.string "street_number", null: false
    t.string "building_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "ship_id", null: false
    t.index ["ship_id"], name: "index_addresses_on_ship_id"
  end

  create_table "images", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "image", null: false
    t.bigint "item_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_images_on_item_id"
  end

  create_table "items", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "product_name", null: false
    t.integer "price", null: false
    t.integer "condition", null: false
    t.text "description", null: false
    t.integer "delivery_fee", null: false
    t.integer "shipping_origin", null: false
    t.integer "days_to_ship", null: false
    t.bigint "user_id", null: false
    t.bigint "seller_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "buyer_id"
    t.index ["buyer_id"], name: "index_items_on_buyer_id"
    t.index ["seller_id"], name: "index_items_on_seller_id"
    t.index ["user_id"], name: "index_items_on_user_id"
  end

  create_table "profiles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "profile"
    t.string "prof_image"
    t.string "family_name", null: false
    t.string "first_name", null: false
    t.string "family_name_kana", null: false
    t.string "first_name_kana", null: false
    t.date "birth_day", null: false
    t.string "mobile", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "ships", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "shipping_family_name"
    t.string "shipping_first_name"
    t.string "shipping_family_name_kana"
    t.string "shipping_first_name_kana"
    t.string "mobile"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_ships_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "nickname"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "addresses", "ships"
  add_foreign_key "images", "items"
  add_foreign_key "items", "users"
  add_foreign_key "items", "users", column: "buyer_id"
  add_foreign_key "items", "users", column: "seller_id"
  add_foreign_key "profiles", "users"
end
