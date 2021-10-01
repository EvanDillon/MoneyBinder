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

ActiveRecord::Schema.define(version: 2021_09_29_144609) do

  create_table "accounts", force: :cascade do |t|
    t.integer "user_id"
    t.string "name", null: false
    t.integer "account_number", null: false
    t.string "description"
    t.string "normal_side"
    t.string "category"
    t.string "subcategory"
    t.integer "initial_balance", default: 0
    t.integer "debit", default: 0
    t.integer "credit", default: 0
    t.integer "balance", default: 0
    t.string "order"
    t.string "statement"
    t.text "comment"
    t.boolean "active", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_accounts_on_user_id"
  end

  create_table "error_messages", force: :cascade do |t|
    t.string "error_name"
    t.text "body"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "password_authorizations", force: :cascade do |t|
    t.integer "user_id"
    t.integer "security_question_id"
    t.string "answer"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["security_question_id"], name: "index_password_authorizations_on_security_question_id"
    t.index ["user_id"], name: "index_password_authorizations_on_user_id"
  end

  create_table "security_questions", force: :cascade do |t|
    t.string "question"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "userType", default: 3
    t.string "firstName"
    t.string "lastName"
    t.date "dob"
    t.string "email"
    t.string "phoneNum"
    t.string "address"
    t.datetime "passUpdatedAt", default: "2021-09-16 05:04:31"
    t.boolean "active", default: true
    t.string "reset"
    t.integer "loginAttempts", default: 0
    t.datetime "suspendedTill", default: "2021-09-20 18:40:34"
  end

  add_foreign_key "accounts", "users"
  add_foreign_key "password_authorizations", "security_questions"
  add_foreign_key "password_authorizations", "users"
end
