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

ActiveRecord::Schema.define(version: 2020_12_10_222010) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "batch_scores", force: :cascade do |t|
    t.string "batch", null: false
    t.integer "score_1", default: 0, null: false
    t.integer "bonus_1", default: 0, null: false
    t.integer "score_2", default: 0, null: false
    t.integer "bonus_2", default: 0, null: false
    t.integer "score_3", default: 0, null: false
    t.integer "bonus_3", default: 0, null: false
    t.integer "score_4", default: 0, null: false
    t.integer "bonus_4", default: 0, null: false
    t.integer "score_5", default: 0, null: false
    t.integer "bonus_5", default: 0, null: false
    t.integer "score_6", default: 0, null: false
    t.integer "bonus_6", default: 0, null: false
    t.integer "score_7", default: 0, null: false
    t.integer "bonus_7", default: 0, null: false
    t.integer "score_8", default: 0, null: false
    t.integer "bonus_8", default: 0, null: false
    t.integer "score_9", default: 0, null: false
    t.integer "bonus_9", default: 0, null: false
    t.integer "score_10", default: 0, null: false
    t.integer "bonus_10", default: 0, null: false
    t.integer "score_11", default: 0, null: false
    t.integer "bonus_11", default: 0, null: false
    t.integer "score_12", default: 0, null: false
    t.integer "bonus_12", default: 0, null: false
    t.integer "score_13", default: 0, null: false
    t.integer "bonus_13", default: 0, null: false
    t.integer "score_14", default: 0, null: false
    t.integer "bonus_14", default: 0, null: false
    t.integer "score_15", default: 0, null: false
    t.integer "bonus_15", default: 0, null: false
    t.integer "score_16", default: 0, null: false
    t.integer "bonus_16", default: 0, null: false
    t.integer "score_17", default: 0, null: false
    t.integer "bonus_17", default: 0, null: false
    t.integer "score_18", default: 0, null: false
    t.integer "bonus_18", default: 0, null: false
    t.integer "score_19", default: 0, null: false
    t.integer "bonus_19", default: 0, null: false
    t.integer "score_20", default: 0, null: false
    t.integer "bonus_20", default: 0, null: false
    t.integer "score_21", default: 0, null: false
    t.integer "bonus_21", default: 0, null: false
    t.integer "score_22", default: 0, null: false
    t.integer "bonus_22", default: 0, null: false
    t.integer "score_23", default: 0, null: false
    t.integer "bonus_23", default: 0, null: false
    t.integer "score_24", default: 0, null: false
    t.integer "bonus_24", default: 0, null: false
    t.integer "score_25", default: 0, null: false
    t.integer "bonus_25", default: 0, null: false
    t.integer "score_total", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "batches", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "individual_scores", force: :cascade do |t|
    t.string "username", null: false
    t.string "batch", null: false
    t.integer "score_1", default: 0, null: false
    t.integer "score_2", default: 0, null: false
    t.integer "score_3", default: 0, null: false
    t.integer "score_4", default: 0, null: false
    t.integer "score_5", default: 0, null: false
    t.integer "score_6", default: 0, null: false
    t.integer "score_7", default: 0, null: false
    t.integer "score_8", default: 0, null: false
    t.integer "score_9", default: 0, null: false
    t.integer "score_10", default: 0, null: false
    t.integer "score_11", default: 0, null: false
    t.integer "score_12", default: 0, null: false
    t.integer "score_13", default: 0, null: false
    t.integer "score_14", default: 0, null: false
    t.integer "score_15", default: 0, null: false
    t.integer "score_16", default: 0, null: false
    t.integer "score_17", default: 0, null: false
    t.integer "score_18", default: 0, null: false
    t.integer "score_19", default: 0, null: false
    t.integer "score_20", default: 0, null: false
    t.integer "score_21", default: 0, null: false
    t.integer "score_22", default: 0, null: false
    t.integer "score_23", default: 0, null: false
    t.integer "score_24", default: 0, null: false
    t.integer "score_25", default: 0, null: false
    t.integer "score_total", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "pseudo", default: "", null: false
    t.string "challenger_id", default: "", null: false
    t.bigint "batch_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["batch_id"], name: "index_users_on_batch_id"
  end

  add_foreign_key "users", "batches"
end
