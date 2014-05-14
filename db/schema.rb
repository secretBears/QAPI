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

ActiveRecord::Schema.define(version: 20140514123044) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "answers", force: true do |t|
    t.text    "answer"
    t.integer "question_id"
    t.boolean "is_true"
  end

  add_index "answers", ["question_id"], name: "index_answers_on_question_id", using: :btree

  create_table "api_keys", force: true do |t|
    t.string   "token"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "requests"
  end

  add_index "api_keys", ["user_id"], name: "index_api_keys_on_user_id", using: :btree

  create_table "places", force: true do |t|
    t.float    "latitude"
    t.float    "longitude"
    t.string   "city"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state"
    t.string   "country"
  end

  create_table "queries", force: true do |t|
    t.text "query_hash"
    t.text "location_property"
    t.text "answer_property"
  end

  create_table "question_placeholders", force: true do |t|
    t.string   "key"
    t.string   "value"
    t.integer  "question_template_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "question_templates", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "question"
    t.integer  "query_id"
  end

  add_index "question_templates", ["query_id"], name: "index_question_templates_on_query_id", using: :btree

  create_table "questions", force: true do |t|
    t.text     "question"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "place_id"
    t.integer  "question_template_id"
  end

  add_index "questions", ["place_id"], name: "index_questions_on_place_id", using: :btree

  create_table "users", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
