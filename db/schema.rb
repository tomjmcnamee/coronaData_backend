# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_03_18_034005) do

  create_table "processed_stats", force: :cascade do |t|
    t.integer "state_id", null: false
    t.string "count_type"
    t.integer "20200304"
    t.integer "20200305"
    t.integer "20200306"
    t.integer "20200307"
    t.integer "20200308"
    t.integer "20200309"
    t.integer "20200310"
    t.integer "20200311"
    t.integer "20200312"
    t.integer "20200313"
    t.integer "20200314"
    t.integer "20200315"
    t.integer "20200316"
    t.integer "20200317"
    t.integer "20200318"
    t.integer "20200319"
    t.integer "20200320"
    t.integer "20200321"
    t.integer "20200322"
    t.integer "20200323"
    t.integer "20200324"
    t.integer "20200325"
    t.integer "20200326"
    t.integer "20200327"
    t.integer "20200328"
    t.integer "20200329"
    t.integer "20200330"
    t.integer "20200331"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["state_id"], name: "index_processed_stats_on_state_id"
  end

  create_table "raw_stats", force: :cascade do |t|
    t.integer "date"
    t.string "state"
    t.integer "positive"
    t.integer "negative"
    t.integer "pending"
    t.integer "death"
    t.integer "total"
    t.datetime "dateChecked"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "states", force: :cascade do |t|
    t.string "state_name"
    t.string "state_abbreviation"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "total_stats", force: :cascade do |t|
    t.integer "date"
    t.integer "state_id", null: false
    t.integer "count"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["state_id"], name: "index_total_stats_on_state_id"
  end

  add_foreign_key "processed_stats", "states"
  add_foreign_key "total_stats", "states"
end