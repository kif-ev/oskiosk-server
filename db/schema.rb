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

ActiveRecord::Schema.define(version: 2021_01_24_152720) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cart_items", id: :serial, force: :cascade do |t|
    t.integer "quantity", default: 0
    t.integer "cart_id"
    t.integer "pricing_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "carts", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "lock_version"
    t.boolean "processing"
  end

  create_table "identifiers", id: :serial, force: :cascade do |t|
    t.string "code"
    t.string "identifiable_type"
    t.integer "identifiable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["code"], name: "index_identifiers_on_code"
    t.index ["identifiable_type", "identifiable_id"], name: "index_identifiers_on_identifiable_type_and_identifiable_id"
  end

  create_table "oauth_access_grants", id: :serial, force: :cascade do |t|
    t.integer "resource_owner_id", null: false
    t.integer "application_id", null: false
    t.string "token", null: false
    t.integer "expires_in", null: false
    t.text "redirect_uri", null: false
    t.datetime "created_at", null: false
    t.datetime "revoked_at"
    t.string "scopes"
    t.index ["token"], name: "index_oauth_access_grants_on_token", unique: true
  end

  create_table "oauth_access_tokens", id: :serial, force: :cascade do |t|
    t.integer "resource_owner_id"
    t.integer "application_id"
    t.string "token", null: false
    t.string "refresh_token"
    t.integer "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at", null: false
    t.string "scopes"
    t.index ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true
    t.index ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_tokens_on_token", unique: true
  end

  create_table "oauth_applications", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.string "uid", null: false
    t.string "secret", null: false
    t.text "redirect_uri", null: false
    t.string "scopes", default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "confidential", default: true, null: false
    t.index ["uid"], name: "index_oauth_applications_on_uid", unique: true
  end

  create_table "pricings", id: :serial, force: :cascade do |t|
    t.integer "price", default: 0
    t.integer "quantity", default: 0
    t.integer "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["product_id"], name: "index_pricings_on_product_id"
  end

  create_table "products", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", id: :serial, force: :cascade do |t|
    t.integer "tag_id"
    t.string "taggable_type"
    t.integer "taggable_id"
    t.string "tagger_type"
    t.integer "tagger_id"
    t.string "context", limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy"
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id"
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type"
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type"
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id"
  end

  create_table "tags", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "transaction_items", id: :serial, force: :cascade do |t|
    t.integer "transaction_id"
    t.integer "product_id"
    t.integer "price"
    t.string "name"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_transaction_items_on_product_id"
    t.index ["transaction_id"], name: "index_transaction_items_on_transaction_id"
  end

  create_table "transactions", id: :serial, force: :cascade do |t|
    t.integer "amount", default: 0
    t.string "user_name"
    t.integer "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "transaction_type"
    t.string "application_name"
    t.integer "application_id"
    t.index ["user_id"], name: "index_transactions_on_user_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "balance", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "allow_negative_balance", default: false
  end

  add_foreign_key "transaction_items", "products"
  add_foreign_key "transaction_items", "transactions"
end
