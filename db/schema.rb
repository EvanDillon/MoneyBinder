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

ActiveRecord::Schema.define(version: 2021_09_19_014848) do

  create_table "password_authorization", force: :cascade do |t|
    t.integer "user_id"
    t.integer "password_question_id"
    t.string "answer"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["password_question_id"], name: "index_password_authorization_on_password_question_id"
    t.index ["user_id"], name: "index_password_authorization_on_user_id"
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
    t.datetime "passUpdatedAt", default: "2021-09-11 16:03:52"
    t.boolean "active", default: true
    t.string "reset"
  end

  add_foreign_key "password_authorization", "password_questions"
  add_foreign_key "password_authorization", "users"
end
