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

ActiveRecord::Schema.define(version: 20160731212157) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "has_taken_qset", id: false, force: :cascade do |t|
    t.integer "qset_id", null: false
    t.integer "user_id", null: false
  end

  create_table "qsets", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  create_table "qsets_questions", id: false, force: :cascade do |t|
    t.integer "qset_id",     null: false
    t.integer "question_id", null: false
  end

  add_index "qsets_questions", ["qset_id", "question_id"], name: "index_qsets_questions_on_qset_id_and_question_id", using: :btree
  add_index "qsets_questions", ["question_id", "qset_id"], name: "index_qsets_questions_on_question_id_and_qset_id", using: :btree

  create_table "qsets_school_classes", id: false, force: :cascade do |t|
    t.integer "school_class_id", null: false
    t.integer "qset_id",         null: false
  end

  add_index "qsets_school_classes", ["qset_id", "school_class_id"], name: "index_qsets_school_classes_on_qset_id_and_school_class_id", using: :btree
  add_index "qsets_school_classes", ["school_class_id", "qset_id"], name: "index_qsets_school_classes_on_school_class_id_and_qset_id", using: :btree

  create_table "question_result_data", force: :cascade do |t|
    t.integer "attempts", limit: 8
    t.integer "success",  limit: 8
    t.integer "failures", limit: 8
    t.decimal "average"
  end

  create_table "question_results", force: :cascade do |t|
    t.string   "question"
    t.string   "correct_answer"
    t.string   "user_answer"
    t.boolean  "correct?"
    t.string   "tag"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "user_id"
    t.integer  "set_result_id"
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
    t.integer  "user_id"
  end

  create_table "school_classes", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "teacher"
  end

  create_table "school_classes_users", id: false, force: :cascade do |t|
    t.integer "school_class_id", null: false
    t.integer "user_id",         null: false
  end

  add_index "school_classes_users", ["school_class_id", "user_id"], name: "index_school_classes_users_on_school_class_id_and_user_id", using: :btree
  add_index "school_classes_users", ["user_id", "school_class_id"], name: "index_school_classes_users_on_user_id_and_school_class_id", using: :btree

  create_table "set_results", force: :cascade do |t|
    t.string   "number_of_questions"
    t.string   "questions_correct"
    t.decimal  "score"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "user_id"
    t.integer  "qset_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "phone"
    t.string   "password_digest"
    t.string   "role"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "verify_code"
    t.boolean  "is_verified"
  end

end
