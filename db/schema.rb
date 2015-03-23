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

ActiveRecord::Schema.define(version: 20150323213327) do

  create_table "constraint_days", force: :cascade do |t|
    t.time     "avail_starting"
    t.time     "avail_ending"
    t.time     "hold_for_perf_starts"
    t.time     "hold_for_perf_ends"
    t.string   "name"
    t.boolean  "is_special_hold"
    t.date     "special_hold_date"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "constraint_week_templates", force: :cascade do |t|
    t.integer  "max_lookahead_for_reh"
    t.integer  "max_lookahead_for_perf"
    t.integer  "release_unbooked_perf_lookahead"
    t.date     "active_starting"
    t.integer  "monday_id"
    t.integer  "tuesday_id"
    t.integer  "wednesday_id"
    t.integer  "thursday_id"
    t.integer  "friday_id"
    t.integer  "saturday_id"
    t.integer  "sunday_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "constraint_week_templates", ["friday_id"], name: "index_constraint_week_templates_on_friday_id"
  add_index "constraint_week_templates", ["monday_id"], name: "index_constraint_week_templates_on_monday_id"
  add_index "constraint_week_templates", ["saturday_id"], name: "index_constraint_week_templates_on_saturday_id"
  add_index "constraint_week_templates", ["sunday_id"], name: "index_constraint_week_templates_on_sunday_id"
  add_index "constraint_week_templates", ["thursday_id"], name: "index_constraint_week_templates_on_thursday_id"
  add_index "constraint_week_templates", ["tuesday_id"], name: "index_constraint_week_templates_on_tuesday_id"
  add_index "constraint_week_templates", ["wednesday_id"], name: "index_constraint_week_templates_on_wednesday_id"

  create_table "reservations", force: :cascade do |t|
    t.integer  "user_id"
    t.date     "date"
    t.time     "start_time"
    t.time     "end_time"
    t.boolean  "is_performance"
    t.boolean  "fee_is_processed"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "reservations", ["user_id"], name: "index_reservations_on_user_id"

  create_table "users", force: :cascade do |t|
    t.integer  "default_hrs_per_month"
    t.string   "username"
    t.string   "email"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

end
