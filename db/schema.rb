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

ActiveRecord::Schema.define(version: 20150218040302) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "car_makes", force: :cascade do |t|
    t.integer  "model_year_id"
    t.string   "make_name"
    t.string   "make_nice_name"
    t.string   "cmodel_name"
    t.string   "cmodel_nice_name"
    t.integer  "year"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "car_profiles", force: :cascade do |t|
    t.integer  "model_year_id"
    t.string   "make"
    t.string   "model"
    t.integer  "year"
    t.string   "engine_code"
    t.string   "name"
    t.integer  "car_make_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "user_id"
  end

  create_table "maintenance_actions", force: :cascade do |t|
    t.integer  "model_year_id"
    t.integer  "car_make_id"
    t.string   "external_id"
    t.string   "engine_code"
    t.string   "transmission_code"
    t.string   "interval_month"
    t.integer  "interval_mileage"
    t.integer  "frequency"
    t.string   "action"
    t.string   "item"
    t.string   "item_description"
    t.float    "labor_units"
    t.float    "parts_units"
    t.float    "part_cost_per_unit"
    t.string   "drive_type"
    t.string   "model_year"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "maintenance_actions", ["external_id"], name: "index_maintenance_actions_on_external_id", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
  end

  add_foreign_key "car_profiles", "users"
end
