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

ActiveRecord::Schema.define(version: 2025_03_03_192318) do

  create_table "accounts", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "bank_name", null: false
    t.string "cbu", null: false
    t.string "alias"
    t.decimal "balance", precision: 15, scale: 2, default: "0.0"
    t.string "currency", default: "ARS", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_accounts_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "full_name"
    t.string "phone_number"
    t.boolean "is_verified", default: false
    t.string "auth_token"
    t.string "profile_picture_url"
    t.boolean "is_active", default: true
    t.datetime "dob"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "accounts", "users"
end
