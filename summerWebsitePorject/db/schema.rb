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

ActiveRecord::Schema.define(version: 20160603215139) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "qsets", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "question_result_data", force: :cascade do |t|
    t.integer "attempts", limit: 8
    t.integer "success",  limit: 8
    t.integer "failures", limit: 8
    t.decimal "average"
  end

  create_table "questions", force: :cascade do |t|
    t.string   "question_text"
    t.string   "answer"
    t.string   "dist1"
    t.string   "dist2"
    t.string   "dist3"
    t.string   "tag"
    t.string   "distractors"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "students", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teachers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
