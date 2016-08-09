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

ActiveRecord::Schema.define(version: 20160809193349) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.string   "text",        limit: 140,                 null: false
    t.boolean  "anonymous",               default: false, null: false
    t.boolean  "accepted",                default: false
    t.datetime "created_at",                              null: false
    t.integer  "question_id",                             null: false
    t.integer  "person_id",                               null: false
    t.index ["person_id"], name: "index_answers_on_person_id", using: :btree
    t.index ["question_id"], name: "index_answers_on_question_id", using: :btree
  end

  create_table "enrolls", force: :cascade do |t|
    t.integer "profile",        null: false
    t.integer "person_id",      null: false
    t.integer "instruction_id", null: false
    t.index ["instruction_id"], name: "index_enrolls_on_instruction_id", using: :btree
    t.index ["person_id", "instruction_id"], name: "index_enrolls_on_person_id_and_instruction_id", unique: true, using: :btree
    t.index ["person_id"], name: "index_enrolls_on_person_id", using: :btree
  end

  create_table "events", force: :cascade do |t|
    t.string  "code",     limit: 30,                                          null: false
    t.string  "name",     limit: 100,                                         null: false
    t.decimal "workload",             precision: 7, scale: 2, default: "0.0", null: false
    t.index ["code"], name: "index_events_on_code", unique: true, using: :btree
  end

  create_table "instructions", force: :cascade do |t|
    t.integer "class_number", default: 1, null: false
    t.date    "start_date",               null: false
    t.date    "end_date",                 null: false
    t.integer "event_id",                 null: false
    t.integer "lecture_id",               null: false
    t.index ["event_id"], name: "index_instructions_on_event_id", using: :btree
    t.index ["lecture_id"], name: "index_instructions_on_lecture_id", using: :btree
  end

  create_table "lectures", force: :cascade do |t|
    t.string  "code",     limit: 30,                                          null: false
    t.string  "name",     limit: 100,                                         null: false
    t.decimal "workload",             precision: 7, scale: 2, default: "0.0", null: false
    t.index ["code"], name: "index_lectures_on_code", unique: true, using: :btree
  end

  create_table "materials", force: :cascade do |t|
    t.string   "name"
    t.string   "mime"
    t.text     "key",                             null: false
    t.boolean  "checked",         default: false
    t.datetime "uploaded_at"
    t.string   "attachable_type"
    t.integer  "attachable_id"
    t.integer  "person_id",                       null: false
    t.index ["attachable_type", "attachable_id"], name: "index_materials_on_attachable_type_and_attachable_id", using: :btree
    t.index ["person_id"], name: "index_materials_on_person_id", using: :btree
  end

  create_table "people", force: :cascade do |t|
    t.string  "name",    limit: 100, null: false
    t.integer "user_id",             null: false
    t.index ["user_id"], name: "index_people_on_user_id", using: :btree
  end

  create_table "presentations", force: :cascade do |t|
    t.string   "subject",        limit: 100,             null: false
    t.integer  "status",                     default: 0, null: false
    t.datetime "created_at",                             null: false
    t.integer  "instruction_id",                         null: false
    t.integer  "person_id",                              null: false
    t.index ["instruction_id"], name: "index_presentations_on_instruction_id", using: :btree
    t.index ["person_id"], name: "index_presentations_on_person_id", using: :btree
  end

  create_table "questions", force: :cascade do |t|
    t.string   "text",            limit: 140,                 null: false
    t.boolean  "anonymous",                   default: false, null: false
    t.datetime "created_at",                                  null: false
    t.integer  "presentation_id",                             null: false
    t.integer  "person_id",                                   null: false
    t.index ["person_id"], name: "index_questions_on_person_id", using: :btree
    t.index ["presentation_id"], name: "index_questions_on_presentation_id", using: :btree
  end

  create_table "redefine_tokens", force: :cascade do |t|
    t.string   "token",      limit: 192, null: false
    t.integer  "user_id",                null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["user_id"], name: "index_redefine_tokens_on_user_id", using: :btree
  end

  create_table "sessions", force: :cascade do |t|
    t.string   "token",      limit: 192, null: false
    t.integer  "user_id",                null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["token"], name: "index_sessions_on_token", unique: true, using: :btree
    t.index ["user_id"], name: "index_sessions_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string "email",           limit: 100, null: false
    t.string "password_digest",             null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
  end

  create_table "votes", force: :cascade do |t|
    t.boolean "up",           default: true, null: false
    t.integer "person_id",                   null: false
    t.string  "votable_type",                null: false
    t.integer "votable_id",                  null: false
    t.index ["person_id", "votable_id", "votable_type"], name: "index_votes_on_person_id_and_votable_id_and_votable_type", unique: true, using: :btree
    t.index ["person_id"], name: "index_votes_on_person_id", using: :btree
    t.index ["votable_type", "votable_id"], name: "index_votes_on_votable_type_and_votable_id", using: :btree
  end

  add_foreign_key "answers", "people"
  add_foreign_key "answers", "questions"
  add_foreign_key "enrolls", "instructions"
  add_foreign_key "enrolls", "people"
  add_foreign_key "instructions", "events"
  add_foreign_key "instructions", "lectures"
  add_foreign_key "materials", "people"
  add_foreign_key "people", "users"
  add_foreign_key "presentations", "instructions"
  add_foreign_key "presentations", "people"
  add_foreign_key "questions", "people"
  add_foreign_key "questions", "presentations"
  add_foreign_key "redefine_tokens", "users"
  add_foreign_key "sessions", "users"
  add_foreign_key "votes", "people"
end
