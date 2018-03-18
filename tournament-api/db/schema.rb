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

ActiveRecord::Schema.define(version: 20180317232617) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "groups", force: :cascade do |t|
    t.string   "name",          limit: 50, null: false
    t.integer  "tournament_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["tournament_id"], name: "index_groups_on_tournament_id", using: :btree
  end

  create_table "matches", force: :cascade do |t|
    t.string   "name",       limit: 50,  null: false
    t.string   "time",       limit: 20,  null: false
    t.date     "date",                   null: false
    t.string   "score",      limit: 100, null: false
    t.integer  "group_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "venue_id"
    t.index ["group_id"], name: "index_matches_on_group_id", using: :btree
    t.index ["name"], name: "index_matches_on_name", using: :btree
    t.index ["venue_id"], name: "index_matches_on_venue_id", using: :btree
  end

  create_table "player_in_groups", force: :cascade do |t|
    t.integer  "player_id"
    t.integer  "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_player_in_groups_on_group_id", using: :btree
    t.index ["player_id"], name: "index_player_in_groups_on_player_id", using: :btree
  end

  create_table "players", force: :cascade do |t|
    t.string   "name",       limit: 100, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["name"], name: "index_players_on_name", using: :btree
  end

  create_table "take_place_matches", force: :cascade do |t|
    t.integer  "player_id"
    t.integer  "match_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "point",      default: 0
    t.index ["match_id"], name: "index_take_place_matches_on_match_id", using: :btree
    t.index ["player_id"], name: "index_take_place_matches_on_player_id", using: :btree
  end

  create_table "tournaments", force: :cascade do |t|
    t.string   "name",       limit: 100, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["name"], name: "index_tournaments_on_name", using: :btree
  end

  create_table "venues", force: :cascade do |t|
    t.string   "name",       limit: 100, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

end
