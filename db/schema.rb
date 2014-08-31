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

ActiveRecord::Schema.define(:version => 20140831175601) do

  create_table "admin_logs", :force => true do |t|
    t.string   "user_id"
    t.string   "browser"
    t.string   "ip_address"
    t.string   "controller"
    t.string   "action"
    t.text     "params"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
  end

  create_table "categories", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "comments", :force => true do |t|
    t.text     "content"
    t.integer  "move_id"
    t.integer  "user_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "tomato_id"
  end

  create_table "interruptions", :force => true do |t|
    t.text     "body"
    t.integer  "interruption_type"
    t.integer  "user_id"
    t.integer  "tomato_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "live_tomatoes", :force => true do |t|
    t.text     "title"
    t.text     "starttime"
    t.text     "endtime"
    t.integer  "currenttime"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "userid"
    t.text     "username"
    t.integer  "status"
    t.integer  "tomato_id"
    t.integer  "thumb_rating"
    t.integer  "star_rating"
  end

  create_table "media", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "artist"
    t.string   "composer"
    t.string   "arranger"
    t.string   "writer"
    t.string   "catalog"
    t.string   "publisher"
    t.integer  "state_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "move_types", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.boolean  "thumb_rating"
    t.boolean  "star_rating"
    t.boolean  "has_tomatoes"
    t.boolean  "has_twitter_idea"
    t.integer  "tomatoes_number"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.boolean  "make_my_day",      :default => false
    t.boolean  "make_my_sprint"
    t.boolean  "is_user_story"
  end

  create_table "move_types_projects", :id => false, :force => true do |t|
    t.integer "project_id"
    t.integer "move_type_id"
  end

  add_index "move_types_projects", ["project_id", "move_type_id"], :name => "index_project_move_types_on_project_id_and_move_type_id"

  create_table "move_types_widgets", :id => false, :force => true do |t|
    t.integer "move_type_id"
    t.integer "widget_id"
  end

  add_index "move_types_widgets", ["move_type_id", "widget_id"], :name => "index_move_types_widgets_on_move_type_id_and_widget_id"

  create_table "moves", :force => true do |t|
    t.text     "body"
    t.integer  "move_type_id"
    t.integer  "user_id"
    t.integer  "state_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "title"
    t.date     "publish_date"
    t.integer  "project_id"
    t.integer  "category_id"
    t.date     "start_date"
    t.datetime "planned_at"
    t.integer  "user_story_id"
  end

  create_table "moves_users", :id => false, :force => true do |t|
    t.integer "move_id"
    t.integer "user_id"
  end

  add_index "moves_users", ["move_id", "user_id"], :name => "index_moves_users_on_move_id_and_user_id"

  create_table "projects", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "projects_users", :id => false, :force => true do |t|
    t.integer "project_id"
    t.integer "user_id"
  end

  add_index "projects_users", ["project_id", "user_id"], :name => "index_projects_users_on_project_id_and_user_id"

  create_table "ratings", :force => true do |t|
    t.text     "body"
    t.integer  "star_rating"
    t.integer  "thumb_rating"
    t.integer  "user_id"
    t.integer  "move_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "tomato_id"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], :name => "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "states", :force => true do |t|
    t.text     "body"
    t.integer  "position"
    t.integer  "visibility"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "title"
    t.integer  "project_id"
  end

  create_table "tomatoes", :force => true do |t|
    t.text     "body"
    t.integer  "state"
    t.string   "title"
    t.integer  "user_id"
    t.integer  "move_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.date     "publish_date"
    t.time     "start_time"
    t.time     "end_time"
    t.integer  "project_id"
    t.integer  "move_type_id"
    t.text     "results"
  end

  create_table "tomatoes_users", :id => false, :force => true do |t|
    t.integer "tomato_id"
    t.integer "user_id"
  end

  add_index "tomatoes_users", ["tomato_id", "user_id"], :name => "index_tomatoes_users_on_tomato_id_and_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0,  :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "name"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id"

  create_table "widgets", :force => true do |t|
    t.string   "title"
    t.string   "path"
    t.integer  "widget_type"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

end
