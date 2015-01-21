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

ActiveRecord::Schema.define(version: 20150121215010) do

  create_table "charges", force: true do |t|
    t.integer  "user_id"
    t.decimal  "amount",      precision: 6, scale: 2
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ticket_id"
  end

  add_index "charges", ["ticket_id"], name: "index_charges_on_ticket_id"
  add_index "charges", ["user_id"], name: "index_charges_on_user_id"

  create_table "payments", force: true do |t|
    t.integer  "user_id"
    t.decimal  "amount",     precision: 6, scale: 2
    t.integer  "method"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "payments", ["user_id"], name: "index_payments_on_user_id"

  create_table "ticket_types", force: true do |t|
    t.string   "name"
    t.decimal  "price",            precision: 6, scale: 2
    t.integer  "max_number"
    t.integer  "number_allocated"
    t.boolean  "for_sale"
    t.integer  "size"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ticket_group"
  end

  create_table "tickets", force: true do |t|
    t.string   "name"
    t.integer  "status"
    t.integer  "donation"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "second_name"
    t.integer  "ticket_type_id"
  end

  add_index "tickets", ["ticket_type_id"], name: "index_tickets_on_ticket_type_id"
  add_index "tickets", ["user_id"], name: "index_tickets_on_user_id"

  create_table "users", force: true do |t|
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
    t.string   "provider"
    t.string   "uid"
    t.boolean  "admin"
    t.boolean  "alumnus"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
