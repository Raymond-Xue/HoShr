# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_02_26_004000) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "properties", force: :cascade do |t|
    t.float "latitude"
    t.float "longitude"
    t.string "street_address"
    t.string "city_id"
    t.string "state_id"
    t.string "country_id"
    t.string "zipcode"
    t.string "owner_id"
    t.integer "n_bedrooms"
    t.string "n_bathroom"
    t.boolean "hasKitchen"
    t.boolean "hasSmokeDetector"
    t.boolean "hasAirConditioning"
    t.string "type_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password"
    t.string "firstname"
    t.string "middlename"
    t.string "lastname"
    t.string "email"
    t.string "gender"
    t.string "occupation"
    t.integer "age"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
