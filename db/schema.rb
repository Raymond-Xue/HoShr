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

ActiveRecord::Schema.define(version: 2020_04_24_020813) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "agree_on_invitations", force: :cascade do |t|
    t.integer "invitation_id"
    t.integer "user_id"
  end

  create_table "cities", force: :cascade do |t|
    t.string "city_name"
    t.string "city_abbr"
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
    t.string "country_abbr"
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

  create_table "disagree_on_invitations", force: :cascade do |t|
    t.integer "invitation_id"
    t.integer "user_id"
  end

  create_table "groups", force: :cascade do |t|
    t.integer "n_lessees"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "active_for_matching", default: true
  end

  create_table "invitations", force: :cascade do |t|
    t.bigint "group_from_id"
    t.bigint "group_to_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "active", default: false
    t.index ["group_from_id"], name: "index_invitations_on_group_from_id"
    t.index ["group_to_id"], name: "index_invitations_on_group_to_id"
  end

  create_table "lessee_requests", force: :cascade do |t|
    t.decimal "latitude"
    t.decimal "longitude"
    t.float "radius"
    t.integer "city_id"
    t.integer "state_id"
    t.integer "country_id"
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
    t.boolean "active", default: true
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
    t.integer "type_id"
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
    t.string "state_abbr"
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

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "cities", "states"
  add_foreign_key "lessee_requests", "groups"
  add_foreign_key "lessor_requests", "properties"
  add_foreign_key "properties", "cities"
  add_foreign_key "properties", "types"
  add_foreign_key "properties", "users", column: "owner_id"
  add_foreign_key "rooms", "properties"
  add_foreign_key "states", "countries"
  add_foreign_key "users", "groups", column: "current_group_id"
  add_foreign_key "users", "groups", column: "origin_group_id"
end
