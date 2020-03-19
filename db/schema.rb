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

ActiveRecord::Schema.define(version: 2020_03_03_053832) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cities", force: :cascade do |t|
    t.string "city_name"
    t.integer "state_id"
    t.integer "country_id"
    t.float "max_latitude"
    t.float "min_latitude"
    t.float "max_longitude"
    t.float "min_longitude"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "countries", force: :cascade do |t|
    t.string "country_name"
    t.float "max_latitude"
    t.float "min_latitude"
    t.float "max_longitude"
    t.float "min_longitude"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "currencies", force: :cascade do |t|
    t.string "currency_name"
    t.string "currency_symbol"
    t.float "conversion_rate_to_usd"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "groups", force: :cascade do |t|
    t.integer "n_lessees"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "invitations", force: :cascade do |t|
    t.bigint "group_from_id"
    t.bigint "group_to_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["group_from_id"], name: "index_invitations_on_group_from_id"
    t.index ["group_to_id"], name: "index_invitations_on_group_to_id"
  end

  create_table "lessee_requests", force: :cascade do |t|
    t.float "latitude"
    t.float "longitude"
    t.float "radius"
    t.integer "city_id"
    t.integer "state_id"
    t.integer "country_id"
    # t.integer "lessee_id"
    t.integer "group_id"
    t.date "earliest_movein_date"
    t.date "latest_movein_date"
    t.integer "min_duration"
    t.integer "max_duration"
    t.integer "duration_unit"
    t.float "max_rent"
    t.integer "max_rent_unit"
    t.integer "max_rent_currency"
    t.integer "max_n_roommates"
    t.integer "max_n_housemates"
    t.boolean "private_bath"
    t.boolean "balcony"
    t.boolean "smoke"
    t.string "roommate_gender"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "lessor_requests", force: :cascade do |t|
    t.integer "property_id"
    t.date "earliest_movein_date"
    t.integer "min_duration"
    t.float "total_rent"
    t.integer "total_rent_currency"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "total_rent_unit"
    t.integer "min_duration_unit"
  end

  create_table "properties", force: :cascade do |t|
    t.float "latitude"
    t.float "longitude"
    t.string "street_address"
    t.integer "city_id"
    t.string "state_id"
    t.string "country_id"
    t.string "zipcode"
    t.integer "owner_id"
    t.integer "n_bedrooms"
    t.string "n_bathroom"
    t.boolean "hasKitchen"
    t.boolean "hasSmokeDetector"
    t.boolean "hasAirConditioning"
    t.string "type_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "rooms", id: false, force: :cascade do |t|
    t.integer "room_id"
    t.integer "property_id"
    t.float "area"
    t.integer "area_unit"
    t.boolean "hasBalcony"
    t.boolean "hasPrivateBath"
    t.boolean "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "states", force: :cascade do |t|
    t.string "state_name"
    t.integer "country_id"
    t.float "max_latitude"
    t.float "min_latitude"
    t.float "max_longitude"
    t.float "min_longitude"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "types", force: :cascade do |t|
    t.string "type_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.string "firstname"
    t.string "middlename"
    t.string "lastname"
    t.string "email"
    t.string "gender"
    t.string "occupation"
    t.integer "age"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "current_group_id"
    t.integer "origin_group_id"
  end

  add_foreign_key "cities", "states"
  add_foreign_key "lessee_requests", "groups"
  add_foreign_key "lessor_requests", "properties"
  add_foreign_key "properties", "cities"
  add_foreign_key "properties", "users", column: "owner_id"
  add_foreign_key "rooms", "properties"
  add_foreign_key "states", "countries"
  add_foreign_key "users", "groups", column: "current_group_id"
  add_foreign_key "users", "groups", column: "origin_group_id"
end
