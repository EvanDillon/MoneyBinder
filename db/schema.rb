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

ActiveRecord::Schema.define(version: 2021_10_18_144449) do

  create_table "accounts", force: :cascade do |t|
    t.integer "user_id"
    t.string "name"
    t.integer "account_number"
    t.string "description"
    t.string "normal_side"
    t.string "category"
    t.string "subcategory"
    t.decimal "initial_balance", default: "0.0"
    t.decimal "debit", default: "0.0"
    t.decimal "credit", default: "0.0"
    t.decimal "balance", default: "0.0"
    t.string "order"
    t.string "statement"
    t.text "comment"
    t.boolean "active", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "contra", default: false
    t.index ["user_id"], name: "index_accounts_on_user_id"
  end

  create_table "error_messages", force: :cascade do |t|
    t.string "error_name"
    t.text "body"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "event_logs", force: :cascade do |t|
    t.string "account_name"
    t.string "user_name"
    t.string "event_type"
    t.string "account_before"
    t.string "account_after"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "journal_entries", force: :cascade do |t|
    t.integer "user_id"
    t.text "debit_account"
    t.text "credit_account"
    t.text "debit_total"
    t.text "credit_total"
    t.string "entry_type"
    t.string "status"
    t.text "description"
    t.date "date_added", default: "2021-10-15"
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
