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

ActiveRecord::Schema.define(version: 20170205031319) do

  create_table "clubs", force: true do |t|
    t.string  "name",      null: false
    t.integer "player_id"
    t.string  "d11",       null: false
    t.string  "d12",       null: false
    t.string  "d13",       null: false
    t.string  "d14",       null: false
    t.string  "d15",       null: false
    t.string  "d16",       null: false
    t.string  "d22",       null: false
    t.string  "d23",       null: false
    t.string  "d24",       null: false
    t.string  "d25",       null: false
    t.string  "d26",       null: false
    t.string  "d33",       null: false
    t.string  "d34",       null: false
    t.string  "d35",       null: false
    t.string  "d36",       null: false
    t.string  "d44",       null: false
    t.string  "d45",       null: false
    t.string  "d46",       null: false
    t.string  "d55",       null: false
    t.string  "d56",       null: false
    t.string  "d66",       null: false
  end

  create_table "holes", force: true do |t|
    t.integer "number",   null: false
    t.integer "par",      null: false
    t.integer "distance", null: false
  end

  create_table "players", force: true do |t|
    t.string  "last_name",  null: false
    t.string  "first_name", null: false
    t.integer "overall",    null: false
  end

  create_table "rounds", force: true do |t|
    t.integer  "tournament_id"
    t.integer  "number",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rounds", ["tournament_id", "number"], name: "index_rounds_on_tournament_id_and_number", unique: true
  add_index "rounds", ["tournament_id"], name: "index_rounds_on_tournament_id"

  create_table "shot_judges", force: true do |t|
    t.string  "prev_result"
    t.string  "lands"
    t.string  "next_use"
    t.integer "next_adjust", default: 0
    t.integer "shot_id"
  end

  add_index "shot_judges", ["shot_id"], name: "index_shot_judges_on_shot_id"

  create_table "shots", force: true do |t|
    t.integer "number",                   null: false
    t.boolean "is_layup", default: false, null: false
    t.integer "hole_id"
  end

  add_index "shots", ["hole_id"], name: "index_shots_on_hole_id"

  create_table "tournaments", force: true do |t|
    t.integer  "year",                           null: false
    t.string   "name",       default: "Masters", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tournaments", ["year"], name: "index_tournaments_on_year", unique: true

end
