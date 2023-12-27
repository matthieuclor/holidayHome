# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2023_12_27_121324) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "hstore"
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", precision: nil, null: false
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
    t.datetime "created_at", precision: nil, null: false
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "admins", force: :cascade do |t|
    t.string "first_name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
  end

  create_table "articles", force: :cascade do |t|
    t.string "title"
    t.string "slug"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_articles_on_slug", unique: true
    t.index ["title"], name: "index_articles_on_title", unique: true
  end

  create_table "booking_approvals", force: :cascade do |t|
    t.bigint "booking_id"
    t.bigint "user_id"
    t.bigint "message_id"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["booking_id"], name: "index_booking_approvals_on_booking_id"
    t.index ["message_id"], name: "index_booking_approvals_on_message_id"
    t.index ["user_id", "booking_id"], name: "index_booking_approvals_on_user_id_and_booking_id", unique: true
    t.index ["user_id"], name: "index_booking_approvals_on_user_id"
  end

  create_table "bookings", force: :cascade do |t|
    t.datetime "from", precision: nil
    t.datetime "to", precision: nil
    t.integer "status", default: 0
    t.bigint "user_id"
    t.bigint "venue_id"
    t.datetime "deadline", precision: nil
    t.string "current_users", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_bookings_on_user_id"
    t.index ["venue_id"], name: "index_bookings_on_venue_id"
  end

  create_table "digital_codes", force: :cascade do |t|
    t.string "name"
    t.string "password"
    t.bigint "venue_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "venue_id"], name: "index_digital_codes_on_name_and_venue_id", unique: true
    t.index ["venue_id"], name: "index_digital_codes_on_venue_id"
  end

  create_table "families", force: :cascade do |t|
    t.string "name"
    t.integer "venues_count", default: 0
    t.integer "days_for_approval"
    t.integer "plan", default: 0
    t.date "plan_deadline"
    t.bigint "creator_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_families_on_creator_id"
  end

  create_table "family_links", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "family_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["family_id", "user_id"], name: "index_family_links_on_family_id_and_user_id", unique: true
    t.index ["family_id"], name: "index_family_links_on_family_id"
    t.index ["user_id"], name: "index_family_links_on_user_id"
  end

  create_table "home_services", force: :cascade do |t|
    t.string "name"
    t.string "person_in_charge"
    t.string "address"
    t.string "phone"
    t.string "email"
    t.bigint "venue_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "venue_id"], name: "index_home_services_on_name_and_venue_id", unique: true
    t.index ["venue_id"], name: "index_home_services_on_venue_id"
  end

  create_table "invitations", force: :cascade do |t|
    t.bigint "sender_id"
    t.bigint "receiver_id"
    t.bigint "family_id"
    t.string "email", default: "", null: false
    t.string "token"
    t.integer "status", default: 0
    t.datetime "last_send_at", precision: nil
    t.integer "send_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["family_id"], name: "index_invitations_on_family_id"
    t.index ["receiver_id"], name: "index_invitations_on_receiver_id"
    t.index ["sender_id"], name: "index_invitations_on_sender_id"
  end

  create_table "keys", force: :cascade do |t|
    t.string "name"
    t.bigint "owner_id"
    t.bigint "venue_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "venue_id"], name: "index_keys_on_name_and_venue_id", unique: true
    t.index ["owner_id"], name: "index_keys_on_owner_id"
    t.index ["venue_id"], name: "index_keys_on_venue_id"
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "booking_id"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["booking_id"], name: "index_messages_on_booking_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "networks", force: :cascade do |t|
    t.string "name"
    t.string "password"
    t.bigint "venue_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "venue_id"], name: "index_networks_on_name_and_venue_id", unique: true
    t.index ["venue_id"], name: "index_networks_on_venue_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "notification_type"
    t.string "description"
    t.string "url"
    t.integer "status", default: 0
    t.bigint "user_id"
    t.bigint "family_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["family_id"], name: "index_notifications_on_family_id"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "question_and_answers", force: :cascade do |t|
    t.string "question"
    t.string "answer"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question"], name: "index_question_and_answers_on_question", unique: true
  end

  create_table "school_holidays", force: :cascade do |t|
    t.string "description"
    t.string "zone"
    t.string "locations", default: [], array: true
    t.string "school_year"
    t.date "from"
    t.date "to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["description", "zone", "school_year"], name: "index_school_holidays_on_description_and_zone_and_school_year", unique: true
  end

  create_table "team_members", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "function"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at", precision: nil
    t.datetime "last_sign_in_at", precision: nil
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at", precision: nil
    t.datetime "confirmation_sent_at", precision: nil
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at", precision: nil
    t.bigint "current_family_id"
    t.string "phone"
    t.string "address"
    t.integer "status", default: 0
    t.hstore "current_venue_id", default: {}
    t.hstore "current_school_holiday_zones", default: {"A"=>"false", "B"=>"false", "C"=>"false"}
    t.integer "plan", default: 0
    t.date "plan_deadline"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["current_venue_id"], name: "index_users_on_current_venue_id", using: :gin
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  create_table "vehicle_types", force: :cascade do |t|
    t.string "name"
    t.integer "icon_prefix", default: 0
    t.string "icon_class"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_vehicle_types_on_name", unique: true
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "vehicle_type"
    t.string "name"
    t.integer "size", default: 0
    t.integer "condition", default: 0
    t.text "comment"
    t.bigint "venue_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["vehicle_type", "name", "venue_id"], name: "index_vehicles_on_vehicle_type_and_name_and_venue_id", unique: true
    t.index ["venue_id"], name: "index_vehicles_on_venue_id"
  end

  create_table "venues", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "city"
    t.string "postcode"
    t.string "country"
    t.string "country_code"
    t.string "administrative"
    t.string "county"
    t.float "lat"
    t.float "lng"
    t.integer "bedrooms_count", default: 0
    t.integer "bathrooms_count", default: 0
    t.integer "single_beds_count", default: 0
    t.integer "double_beds_count", default: 0
    t.integer "baby_beds_count", default: 0
    t.boolean "with_network", default: false
    t.boolean "with_digital_code", default: false
    t.boolean "with_home_service", default: false
    t.text "comment"
    t.boolean "editable_for_others", default: true
    t.bigint "creator_id"
    t.bigint "family_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "single_sofa_beds_count", default: 0
    t.integer "double_sofa_beds_count", default: 0
    t.boolean "with_washing_machine", default: false
    t.boolean "with_tumble_dryer", default: false
    t.boolean "with_dishwasher", default: false
    t.integer "vehicles_count", default: 0
    t.index ["creator_id"], name: "index_venues_on_creator_id"
    t.index ["family_id"], name: "index_venues_on_family_id"
    t.index ["name", "family_id"], name: "index_venues_on_name_and_family_id", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
end
