# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20141231173606) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cart_items", force: true do |t|
    t.integer  "quantity",   default: 0
    t.integer  "cart_id"
    t.integer  "pricing_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "carts", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "identifiers", force: true do |t|
    t.string   "code"
    t.integer  "identifiable_id"
    t.string   "identifiable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "identifiers", ["identifiable_id", "identifiable_type"], name: "index_identifiers_on_identifiable_id_and_identifiable_type", using: :btree

  create_table "pricings", force: true do |t|
    t.integer  "price",      default: 0
    t.integer  "quantity",   default: 0
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pricings", ["product_id"], name: "index_pricings_on_product_id", using: :btree

  create_table "products", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transactions", force: true do |t|
    t.integer  "total_price", default: 0
    t.string   "buyer_name"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "transactions", ["user_id"], name: "index_transactions_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.integer  "balance",    default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
