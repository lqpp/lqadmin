# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120610112544) do

  create_table "instants", :force => true do |t|
    t.string   "dbname"
    t.string   "title"
    t.string   "description"
    t.string   "notes"
    t.string   "url"
    t.integer  "version"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "logs", :force => true do |t|
    t.integer  "user_id"
    t.integer  "instants_id"
    t.string   "action"
    t.string   "parameters"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "permissions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "instants_id"
    t.boolean  "search_fulltext_yesno",       :default => false
    t.boolean  "search_fulltext_username",    :default => false
    t.boolean  "search_fulltext_userid",      :default => false
    t.boolean  "search_fulltext_fulldetails", :default => false
    t.boolean  "check_invite_status",         :default => false
    t.boolean  "check_invite_username",       :default => false
    t.boolean  "check_invite_userid",         :default => false
    t.boolean  "invitecode_sendusermail",     :default => false
    t.boolean  "username_sendfreetextemail",  :default => false
    t.boolean  "invitecode_disable",          :default => false
    t.boolean  "invitecode_create",           :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "pass"
    t.string   "sig"
    t.string   "note"
    t.boolean  "admin"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
