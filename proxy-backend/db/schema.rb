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

ActiveRecord::Schema.define(version: 20150416092261) do

  create_table "entries", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "people", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "proxies", force: :cascade do |t|
    t.string   "proxy",       limit: 255
    t.boolean  "banned",      limit: 1,   default: false
    t.datetime "banned_time"
    t.string   "proxy_type",  limit: 255, default: "http"
    t.float    "succ_ratio",  limit: 24,  default: 0.0
    t.integer  "succ",        limit: 4,   default: 0
    t.integer  "total",       limit: 4,   default: 0
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  create_table "proxy_domains", force: :cascade do |t|
    t.string   "proxy",      limit: 255
    t.string   "domain",     limit: 255
    t.string   "proxy_type", limit: 255, default: "http"
    t.float    "succ_ratio", limit: 24,  default: 0.0
    t.integer  "succ",       limit: 4,   default: 0
    t.integer  "total",      limit: 4,   default: 0
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

end
