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

ActiveRecord::Schema.define(version: 20150327185644) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "codes", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "file_name",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "codes", ["file_name"], name: "index_codes_on_file_name", unique: true, using: :btree
  add_index "codes", ["name"], name: "index_codes_on_name", unique: true, using: :btree

  create_table "proposed_laws", force: :cascade do |t|
    t.integer  "code_id",     null: false
    t.integer  "user_id",     null: false
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "proposed_laws", ["code_id"], name: "index_proposed_laws_on_code_id", using: :btree
  add_index "proposed_laws", ["user_id"], name: "index_proposed_laws_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  add_foreign_key "proposed_laws", "codes"
  add_foreign_key "proposed_laws", "users"
end
