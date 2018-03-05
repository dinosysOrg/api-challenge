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

ActiveRecord::Schema.define(version: 20180305091137) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_groups_on_name"
  end

  create_table "match_results", force: :cascade do |t|
    t.integer "match_id"
    t.integer "player_1_goals"
    t.integer "player_2_goals"
    t.integer "gave_up_player_id"
    t.integer "match_rule_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "match_rules", force: :cascade do |t|
    t.string "name"
    t.integer "winner_point"
    t.integer "looser_point"
    t.integer "drawer_point"
    t.boolean "is_knockout"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "matches", force: :cascade do |t|
    t.datetime "time"
    t.string "match_code"
    t.integer "venue_id"
    t.integer "player_1_id"
    t.integer "player_2_id"
    t.integer "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "venues", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_venues_on_name"
  end

  add_foreign_key "match_results", "match_rules"
  add_foreign_key "match_results", "players", column: "gave_up_player_id"
  add_foreign_key "matches", "groups"
  add_foreign_key "matches", "players", column: "player_1_id"
  add_foreign_key "matches", "players", column: "player_2_id"
  add_foreign_key "matches", "venues"
end
