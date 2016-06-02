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

ActiveRecord::Schema.define(version: 20160519094848) do

  create_table "clients", force: :cascade do |t|
    t.integer  "organization_id"
    t.string   "name"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.boolean  "admin",           default: true
  end

  add_index "clients", ["organization_id"], name: "index_clients_on_organization_id"

  create_table "comments", force: :cascade do |t|
    t.text     "comment"
    t.integer  "organization_id"
    t.integer  "client_id"
    t.integer  "contact_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "calltype"
    t.float    "callduration"
    t.date     "calltime"
  end

  add_index "comments", ["client_id"], name: "index_comments_on_client_id"
  add_index "comments", ["contact_id"], name: "index_comments_on_contact_id"
  add_index "comments", ["organization_id"], name: "index_comments_on_organization_id"

  create_table "contacts", force: :cascade do |t|
    t.string   "email"
    t.string   "phone_number"
    t.integer  "organization_id"
    t.integer  "client_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.boolean  "verified",        default: false
  end

  add_index "contacts", ["client_id"], name: "index_contacts_on_client_id"
  add_index "contacts", ["organization_id"], name: "index_contacts_on_organization_id"

  create_table "organizations", force: :cascade do |t|
    t.string   "organization_name"
    t.text     "address"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.boolean  "admin",             default: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
    t.string   "remember_digest"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
