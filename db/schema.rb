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

ActiveRecord::Schema.define(:version => 20121222200848) do

  create_table "historical_values", :force => true do |t|
    t.datetime "date"
    t.integer  "assessed_value"
    t.integer  "property_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "historical_values", ["property_id", "date"], :name => "index_historical_values_on_property_id_and_date", :unique => true

  create_table "lands", :force => true do |t|
    t.string   "land_id"
    t.string   "type_code"
    t.float    "size_acres"
    t.float    "size_sqft"
    t.integer  "property_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "lands", ["property_id", "land_id"], :name => "index_lands_on_property_id_and_land_id", :unique => true

  create_table "owners", :force => true do |t|
    t.string   "name"
    t.string   "mailing_address"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "owners", ["name", "mailing_address"], :name => "index_owners_on_name_and_mailing_address", :unique => true

  create_table "properties", :force => true do |t|
    t.decimal  "objectid",                                                                          :precision => 10, :scale => 0
    t.decimal  "area"
    t.string   "plat",                             :limit => 6
    t.string   "pid_10",                           :limit => 10
    t.decimal  "prop_id",                                                                           :precision => 10, :scale => 0
    t.string   "lots",                             :limit => 10
    t.string   "situs",                            :limit => 50
    t.string   "blocks",                           :limit => 4
    t.string   "condoid",                          :limit => 15
    t.string   "condoid2",                         :limit => 20
    t.string   "parcel_blo",                       :limit => 50
    t.string   "nbhd",                             :limit => 50
    t.string   "zoning",                           :limit => 50
    t.string   "grid",                             :limit => 50
    t.string   "wcid17",                           :limit => 10
    t.decimal  "shape_area"
    t.decimal  "shape_len"
    t.spatial  "geom",                             :limit => {:srid=>2277, :type=>"multi_polygon"}
    t.string   "address"
    t.string   "legal_name"
    t.float    "land_value"
    t.float    "improvement_value"
    t.float    "assessed_value"
    t.datetime "scraped_at"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "scrape_failed_at"
    t.float    "lot_area"
    t.float    "assessed_value_change_since_2008"
    t.float    "assessed_value_change_since_2000"
    t.boolean  "has_residential"
    t.float    "hvac_residential_area"
    t.float    "assessed_value_per_hvac_sf"
    t.float    "assessed_value_per_lot_sf"
    t.float    "improvement_value_per_hvac_sf"
    t.float    "land_value_per_lot_sf"
    t.float    "weighted_structure_age"
    t.string   "state",                                                                                                            :default => "not_scraped"
  end

  add_index "properties", ["geom"], :name => "properties_geom_gist", :spatial => true
  add_index "properties", ["prop_id"], :name => "index_properties_on_prop_id"
  add_index "properties", ["scrape_failed_at"], :name => "index_properties_on_scrape_failed_at"
  add_index "properties", ["scraped_at"], :name => "index_properties_on_scraped_at"

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

  add_index "structures", ["property_id", "segment_id"], :name => "index_structures_on_property_id_and_segment_id", :unique => true

end
