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

ActiveRecord::Schema.define(version: 20131203194843) do

  create_table "customers", force: true do |t|
    t.string  "name"
    t.string  "card_number"
    t.string  "security_code"
    t.integer "exp_month"
    t.integer "exp_year"
    t.string  "billing_street"
    t.string  "billing_city"
    t.string  "billing_state"
    t.string  "billing_zip"
  end

  create_table "movies", force: true do |t|
    t.string  "title"
    t.string  "director"
    t.string  "star"
    t.integer "release_year"
    t.string  "genre"
    t.string  "rating"
  end

  create_table "sessions", force: true do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at"

end
