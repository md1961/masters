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

ActiveRecord::Schema.define(version: 20150414060702) do

  create_table "clubs", force: true do |t|
    t.string  "name"
    t.integer "player_id"
    t.string  "11"
    t.string  "12"
    t.string  "13"
    t.string  "14"
    t.string  "15"
    t.string  "16"
    t.string  "22"
    t.string  "23"
    t.string  "24"
    t.string  "25"
    t.string  "26"
    t.string  "33"
    t.string  "34"
    t.string  "35"
    t.string  "36"
    t.string  "44"
    t.string  "45"
    t.string  "46"
    t.string  "55"
    t.string  "56"
    t.string  "66"
  end

  create_table "holes", force: true do |t|
    t.integer "number"
    t.integer "par"
    t.integer "distance"
  end

  create_table "players", force: true do |t|
    t.string  "last_name"
    t.string  "first_name"
    t.integer "overall"
  end

  create_table "shot_judges", force: true do |t|
    t.string  "prev_result"
    t.string  "lands"
    t.string  "next_use"
    t.integer "next_adjust", default: 0
    t.integer "shot_id"
  end

  add_index "shot_judges", ["shot_id"], name: "index_shot_judges_on_shot_id"

  create_table "shots", force: true do |t|
    t.integer "number"
    t.boolean "layup",   default: false
    t.integer "hole_id"
  end

  add_index "shots", ["hole_id"], name: "index_shots_on_hole_id"

end
