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

ActiveRecord::Schema.define(:version => 20121220152405) do

  create_table "historical_values", :force => true do |t|
    t.integer  "year"
    t.integer  "assessed_value"
    t.integer  "property_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "lands", :force => true do |t|
    t.string   "type_code"
    t.float    "size_acres"
    t.float    "size_sqft"
    t.integer  "property_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "properties", :force => true do |t|
    t.decimal "objectid",                                                    :precision => 10, :scale => 0
    t.decimal "area"
    t.string  "plat",       :limit => 6
    t.string  "pid_10",     :limit => 10
    t.decimal "prop_id",                                                     :precision => 10, :scale => 0
    t.string  "lots",       :limit => 10
    t.string  "situs",      :limit => 50
    t.string  "blocks",     :limit => 4
    t.string  "condoid",    :limit => 15
    t.string  "condoid2",   :limit => 20
    t.string  "parcel_blo", :limit => 50
    t.string  "nbhd",       :limit => 50
    t.string  "zoning",     :limit => 50
    t.decimal "land_value"
    t.string  "grid",       :limit => 50
    t.string  "wcid17",     :limit => 10
    t.decimal "shape_area"
    t.decimal "shape_len"
    t.spatial "geom",       :limit => {:srid=>4326, :type=>"multi_polygon"}
  end

  add_index "properties", ["geom"], :name => "properties_geom_gist", :spatial => true

  create_table "structures", :force => true do |t|
    t.string   "segment_id"
    t.string   "type_code"
    t.string   "description"
    t.integer  "year_built"
    t.float    "area"
    t.integer  "property_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

end
