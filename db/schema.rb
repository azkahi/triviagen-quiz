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

ActiveRecord::Schema.define(version: 20171123112439) do

  create_table "categories", id: false, force: :cascade do |t|
    t.integer "id",       limit: 4
    t.string  "article",  limit: 37
    t.string  "category", limit: 29
  end

  create_table "new_trivia", force: :cascade do |t|
    t.text     "content",    limit: 65535
    t.text     "title",      limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "openies", id: false, force: :cascade do |t|
    t.integer "id_article", limit: 4
    t.string  "article",    limit: 37
    t.string  "entity1",    limit: 163
    t.string  "relation",   limit: 214
    t.string  "entity2",    limit: 283
  end

  create_table "survey_answers", force: :cascade do |t|
    t.integer  "attempt_id",  limit: 4
    t.integer  "question_id", limit: 4
    t.integer  "option_id",   limit: 4
    t.boolean  "correct",     limit: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "survey_attempts", force: :cascade do |t|
    t.integer "participant_id",   limit: 4
    t.string  "participant_type", limit: 255
    t.integer "survey_id",        limit: 4
    t.boolean "winner",           limit: 1
    t.integer "score",            limit: 4
  end

  create_table "survey_options", force: :cascade do |t|
    t.integer  "question_id", limit: 4
    t.integer  "weight",      limit: 4,    default: 0
    t.string   "text",        limit: 1024
    t.boolean  "correct",     limit: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "survey_questions", force: :cascade do |t|
    t.integer  "survey_id",  limit: 4
    t.string   "text",       limit: 1024
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "survey_surveys", force: :cascade do |t|
    t.string   "name",            limit: 1024
    t.string   "description",     limit: 1024
    t.integer  "attempts_number", limit: 4,    default: 0
    t.boolean  "finished",        limit: 1,    default: false
    t.boolean  "active",          limit: 1,    default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "survey_type",     limit: 4
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "name",       limit: 255
  end

end
