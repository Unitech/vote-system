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

ActiveRecord::Schema.define(:version => 20111007105710) do

  create_table "article_users", :force => true do |t|
    t.integer  "user_id"
    t.integer  "article_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "relation_type"
  end

  create_table "articles", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "link"
    t.text     "tags"
    t.integer  "like_nb"
    t.integer  "dislike_nb"
    t.boolean  "approved"
    t.string   "categorie"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
  end

  add_index "articles", ["user_id"], :name => "index_articles_on_user_id"

  create_table "comments", :force => true do |t|
    t.string   "title"
    t.string   "content"
    t.integer  "article_id"
    t.integer  "user_id"
    t.string   "anonymous_url"
    t.string   "anonymous_nick"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "facebook", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "link"
    t.text     "tags"
    t.integer  "like_nb"
    t.integer  "dislike_nb"
    t.boolean  "approved"
    t.string   "categorie"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
  end

  create_table "rails", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "link"
    t.text     "tags"
    t.integer  "like_nb"
    t.integer  "dislike_nb"
    t.boolean  "approved"
    t.string   "categorie"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
  end

  create_table "rails_admin_histories", :force => true do |t|
    t.string   "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      :limit => 2
    t.integer  "year",       :limit => 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

  create_table "rails_comments", :force => true do |t|
    t.string   "title"
    t.string   "content"
    t.integer  "article_id"
    t.integer  "user_id"
    t.string   "anonymous_url"
    t.string   "anonymous_nick"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sdfsdf", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "link"
    t.text     "tags"
    t.integer  "like_nb"
    t.integer  "dislike_nb"
    t.boolean  "approved"
    t.string   "categorie"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
  end

  create_table "sdfsdf_comments", :force => true do |t|
    t.string   "title"
    t.string   "content"
    t.integer  "article_id"
    t.integer  "user_id"
    t.string   "anonymous_url"
    t.string   "anonymous_nick"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "test", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "link"
    t.text     "tags"
    t.integer  "like_nb"
    t.integer  "dislike_nb"
    t.boolean  "approved"
    t.string   "categorie"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
  end

  create_table "user_votes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "article_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "",    :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "username"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "site_url"
    t.integer  "reputation"
    t.text     "friends_array"
    t.boolean  "admin",                                 :default => false
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "vim", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "link"
    t.text     "tags"
    t.integer  "like_nb"
    t.integer  "dislike_nb"
    t.boolean  "approved"
    t.string   "categorie"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
  end

  create_table "vsconfigs", :force => true do |t|
    t.string   "title"
    t.string   "subdomain"
    t.string   "resume"
    t.string   "table_name"
    t.datetime "date_begin"
    t.string   "stylesheet"
    t.string   "author"
    t.text     "description_left"
    t.text     "description_right"
    t.string   "favicon"
    t.string   "twitter_account"
    t.string   "html5_font"
    t.string   "idhv1"
    t.boolean  "advertisement"
    t.boolean  "ajax_load"
    t.boolean  "anonymous_vote"
    t.boolean  "user_reputation"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "background_color"
    t.string   "text_color"
    t.boolean  "anonymous_comment"
    t.string   "locale"
    t.boolean  "display_title"
    t.string   "editor_type"
    t.boolean  "short_article"
    t.string   "categories"
    t.string   "comment_table_name"
    t.boolean  "private"
  end

end
