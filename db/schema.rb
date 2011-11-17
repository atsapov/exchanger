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

ActiveRecord::Schema.define(:version => 20110915134122) do

  create_table "currencies", :force => true do |t|
    t.string   "symbol"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "exchanges", :force => true do |t|
    t.integer  "bought_id"
    t.integer  "sold_id"
    t.float    "bought_rate"
    t.float    "sold_rate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "purses", :force => true do |t|
    t.integer  "user_id"
    t.integer  "currency_id"
    t.float    "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "purses", ["currency_id"], :name => "index_purses_on_currency_id"
  add_index "purses", ["user_id", "currency_id"], :name => "index_purses_on_user_id_and_currency_id", :unique => true
  add_index "purses", ["user_id"], :name => "index_purses_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "encrypted_password"
    t.string   "salt"
    t.boolean  "admin",              :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
