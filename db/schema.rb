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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121223185356) do

  create_table "irc_channels", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "irc_channels", ["name"], :name => "index_irc_channels_on_name"

  create_table "log_entries", :force => true do |t|
    t.integer  "log_file_id"
    t.datetime "when"
    t.string   "who"
    t.text     "what"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "log_entries", ["log_file_id"], :name => "index_log_entries_on_log_file_id"
  add_index "log_entries", ["who", "when", "what"], :name => "index_log_entries_on_who_and_when_and_what"

  create_table "log_files", :force => true do |t|
    t.integer  "irc_channel_id"
    t.string   "file_name"
    t.date     "file_date"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "log_files", ["irc_channel_id"], :name => "index_log_files_on_irc_channel_id"

end
