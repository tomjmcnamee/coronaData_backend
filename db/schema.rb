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

ActiveRecord::Schema.define(version: 2020_04_02_034005) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "processed_stats", force: :cascade do |t|
    t.bigint "state_id", null: false
    t.string "count_type"
    t.integer "20200228"
    t.integer "20200229"
    t.integer "20200301"
    t.integer "20200302"
    t.integer "20200303"
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
    t.integer "20200401"
    t.integer "20200402"
    t.integer "20200403"
    t.integer "20200404"
    t.integer "20200405"
    t.integer "20200406"
    t.integer "20200407"
    t.integer "20200408"
    t.integer "20200409"
    t.integer "20200410"
    t.integer "20200411"
    t.integer "20200412"
    t.integer "20200413"
    t.integer "20200414"
    t.integer "20200415"
    t.integer "20200416"
    t.integer "20200417"
    t.integer "20200418"
    t.integer "20200419"
    t.integer "20200420"
    t.integer "20200421"
    t.integer "20200422"
    t.integer "20200423"
    t.integer "20200424"
    t.integer "20200425"
    t.integer "20200426"
    t.integer "20200427"
    t.integer "20200428"
    t.integer "20200429"
    t.integer "20200430"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["state_id"], name: "index_processed_stats_on_state_id"
  end

  create_table "raw_stats", force: :cascade do |t|
    t.integer "date"
    t.string "state"
    t.integer "positive"
    t.integer "negative"
    t.integer "hospitalized"
    t.integer "death"
    t.integer "total"
    t.integer "deathIncrease"
    t.integer "hospitalizedIncrease"
    t.integer "negativeIncrease"
    t.integer "positiveIncrease"
    t.integer "totalTestResultsIncrease"
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

  create_table "stay_at_home_orders", force: :cascade do |t|
    t.integer "date"
    t.bigint "state_id", null: false
    t.string "order_action"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["state_id"], name: "index_stay_at_home_orders_on_state_id"
  end

  create_table "total_stats", force: :cascade do |t|
    t.integer "date"
    t.bigint "state_id", null: false
    t.integer "count"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["state_id"], name: "index_total_stats_on_state_id"
  end

  add_foreign_key "processed_stats", "states"
  add_foreign_key "stay_at_home_orders", "states"
  add_foreign_key "total_stats", "states"
end
