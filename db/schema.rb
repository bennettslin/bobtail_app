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

ActiveRecord::Schema.define(version: 20130929015923) do

  create_table "admins", force: true do |t|
    t.string   "name"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.boolean  "super_admin",     default: false
  end

  add_index "admins", ["name"], name: "index_admins_on_name", unique: true

  create_table "albums", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "news_items", force: true do |t|
    t.string   "heading"
    t.text     "entry"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "admin_name"
  end

  create_table "projects", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "order_num"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "admin_id"
  end

  create_table "shows_items", force: true do |t|
    t.string   "name"
    t.string   "webpage"
    t.string   "city"
    t.string   "state"
    t.string   "extra"
    t.datetime "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "songs", force: true do |t|
    t.string   "title"
    t.text     "lyrics"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "order_num"
    t.integer  "album_id"
  end

end
