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

ActiveRecord::Schema.define(version: 2021_11_29_215732) do

  create_table "accounts", force: :cascade do |t|
    t.integer "user_id"
    t.string "name"
    t.integer "account_number"
    t.string "description"
    t.string "normal_side"
    t.string "category"
    t.string "subcategory"
    t.float "initial_balance", default: 0.0
    t.float "debit", default: 0.0
    t.float "credit", default: 0.0
    t.float "balance", default: 0.0
    t.string "order"
    t.string "statement"
    t.text "comment"
    t.boolean "active", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "contra", default: false
    t.index ["user_id"], name: "index_accounts_on_user_id"
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
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
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.integer "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
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

  create_table "ledger_entries", force: :cascade do |t|
    t.integer "account_id"
    t.integer "postReference"
    t.float "debit", default: 0.0
    t.float "credit", default: 0.0
    t.float "balance", default: 0.0
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_ledger_entries_on_account_id"
  end

  create_table "password_join_authorizations", force: :cascade do |t|
    t.integer "user_id"
    t.integer "security_questions_id"
    t.string "answer"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["security_questions_id"], name: "index_password_join_authorizations_on_security_questions_id"
    t.index ["user_id"], name: "index_password_join_authorizations_on_user_id"
  end

  create_table "security_questions", force: :cascade do |t|
    t.string "question"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_event_logs", force: :cascade do |t|
    t.text "user_name", null: false
    t.text "event_type", null: false
    t.text "user_before", null: false
    t.text "user_after", null: false
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
  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "password_join_authorizations", "security_questions", column: "security_questions_id"
  add_foreign_key "password_join_authorizations", "users"
end
