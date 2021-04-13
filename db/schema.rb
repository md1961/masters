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

ActiveRecord::Schema.define(version: 2017_08_18_055611) do

  create_table "areas", force: :cascade do |t|
    t.integer "round_id"
    t.integer "seq_num", null: false
    t.integer "name", default: 0, null: false
    t.index ["round_id"], name: "index_areas_on_round_id"
  end

  create_table "balls", force: :cascade do |t|
    t.integer "player_id"
    t.integer "shot_id"
    t.integer "shot_count", default: 0, null: false
    t.string "result"
    t.string "lands"
    t.string "next_use"
    t.boolean "is_layup", default: false
    t.boolean "is_saved", default: false
    t.integer "next_adjust", default: 0
    t.integer "status", default: 0, null: false
    t.index ["player_id"], name: "index_balls_on_player_id"
    t.index ["shot_id"], name: "index_balls_on_shot_id"
  end

  create_table "club_results", force: :cascade do |t|
    t.integer "club_id"
    t.integer "dice", null: false
    t.string "result", null: false
    t.index ["club_id"], name: "index_club_results_on_club_id"
  end

  create_table "clubs", force: :cascade do |t|
    t.string "name", null: false
    t.integer "player_id"
    t.index ["player_id"], name: "index_clubs_on_player_id"
  end

  create_table "groupings", force: :cascade do |t|
    t.integer "group_id"
    t.integer "player_id"
    t.integer "play_order"
    t.index ["group_id"], name: "index_groupings_on_group_id"
    t.index ["player_id"], name: "index_groupings_on_player_id"
  end

  create_table "groups", force: :cascade do |t|
    t.integer "round_id"
    t.integer "number", null: false
    t.index ["round_id"], name: "index_groups_on_round_id"
  end

  create_table "holes", force: :cascade do |t|
    t.integer "number", null: false
    t.integer "par", null: false
    t.integer "distance", null: false
  end

  create_table "invitations", force: :cascade do |t|
    t.integer "tournament_id"
    t.integer "player_id"
    t.integer "cut_after_round_number_of"
    t.index ["player_id"], name: "index_invitations_on_player_id"
    t.index ["tournament_id"], name: "index_invitations_on_tournament_id"
  end

  create_table "leaders", force: :cascade do |t|
    t.integer "leaders_snapshot_id"
    t.integer "player_id"
    t.integer "rank"
    t.integer "score"
    t.string "hole_finished"
    t.index ["leaders_snapshot_id"], name: "index_leaders_on_leaders_snapshot_id"
    t.index ["player_id"], name: "index_leaders_on_player_id"
  end

  create_table "leaders_snapshots", force: :cascade do |t|
    t.integer "round_id"
    t.integer "seq_num"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["round_id"], name: "index_leaders_snapshots_on_round_id"
  end

  create_table "old_club_results", force: :cascade do |t|
    t.integer "old_club_id"
    t.integer "dice", null: false
    t.string "result", null: false
    t.index ["old_club_id"], name: "index_old_club_results_on_old_club_id"
  end

  create_table "old_clubs", force: :cascade do |t|
    t.string "name", null: false
    t.integer "player_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["player_id"], name: "index_old_clubs_on_player_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "last_name", null: false
    t.string "first_name", null: false
    t.integer "overall", null: false
  end

  create_table "rounds", force: :cascade do |t|
    t.integer "tournament_id"
    t.integer "number", null: false
    t.boolean "is_current", default: false, null: false
    t.integer "status", default: 0, null: false
    t.string "play_result"
    t.string "club_name_for_12_tee"
    t.string "type"
    t.index ["tournament_id", "number"], name: "index_rounds_on_tournament_id_and_number", unique: true
    t.index ["tournament_id"], name: "index_rounds_on_tournament_id"
  end

  create_table "score_cards", force: :cascade do |t|
    t.integer "player_id"
    t.integer "round_id"
    t.index ["player_id"], name: "index_score_cards_on_player_id"
    t.index ["round_id"], name: "index_score_cards_on_round_id"
  end

  create_table "scores", force: :cascade do |t|
    t.integer "score_card_id"
    t.integer "hole_id"
    t.integer "value"
    t.index ["hole_id"], name: "index_scores_on_hole_id"
    t.index ["score_card_id"], name: "index_scores_on_score_card_id"
  end

  create_table "shot_judges", force: :cascade do |t|
    t.string "prev_result"
    t.string "lands"
    t.string "next_use"
    t.integer "next_adjust", default: 0
    t.integer "shot_id"
    t.index ["shot_id"], name: "index_shot_judges_on_shot_id"
  end

  create_table "shots", force: :cascade do |t|
    t.integer "number", null: false
    t.boolean "is_layup", default: false, null: false
    t.integer "area_id", default: 0, null: false
    t.integer "hole_id"
    t.index ["hole_id"], name: "index_shots_on_hole_id"
  end

  create_table "tournaments", force: :cascade do |t|
    t.integer "year", null: false
    t.string "name", default: "Masters", null: false
    t.integer "num_rounds", default: 4, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["year"], name: "index_tournaments_on_year", unique: true
  end

end
