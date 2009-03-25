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

ActiveRecord::Schema.define(:version => 20080928162945) do

  create_table "events", :force => true do |t|
    t.integer  "show_id"
    t.integer  "venue_id"
    t.datetime "start"
    t.datetime "end"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "item_files", :force => true do |t|
    t.integer  "item_id"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "item_linkings", :force => true do |t|
    t.integer "item_id"
    t.integer "item_linking_id"
    t.string  "item_linking_type"
  end

  create_table "item_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "items", :force => true do |t|
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "item_type_id"
    t.boolean  "draft"
    t.string   "stage"
  end

  create_table "organisation_roles", :force => true do |t|
    t.integer "organisation_id"
    t.integer "person_id"
    t.string  "name"
  end

  create_table "organisations", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "organisations_shows", :force => true do |t|
    t.integer "organisation_id"
    t.integer "show_id"
  end

  create_table "people", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "show_roles", :force => true do |t|
    t.integer "person_id"
    t.integer "show_id"
    t.string  "name"
  end

  create_table "shows", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.integer  "camdram_number"
    t.string   "camdram_loginname"
    t.string   "camdram_realname"
    t.integer  "person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "venues", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
