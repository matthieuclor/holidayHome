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

ActiveRecord::Schema.define(version: 2020_11_02_081244) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "hstore"
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

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

  create_table "admins", force: :cascade do |t|
    t.string "first_name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
  end

  create_table "articles", force: :cascade do |t|
    t.string "title"
    t.string "slug"
    t.integer "status", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "booking_approvals", force: :cascade do |t|
    t.bigint "booking_id"
    t.bigint "user_id"
    t.integer "status", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "message_id"
    t.index ["booking_id"], name: "index_booking_approvals_on_booking_id"
    t.index ["message_id"], name: "index_booking_approvals_on_message_id"
    t.index ["user_id"], name: "index_booking_approvals_on_user_id"
  end

  create_table "bookings", force: :cascade do |t|
    t.datetime "from"
    t.datetime "to"
    t.integer "status", default: 0
    t.bigint "user_id"
    t.bigint "venue_id"
    t.datetime "deadline"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "current_users", default: [], array: true
    t.index ["user_id"], name: "index_bookings_on_user_id"
    t.index ["venue_id"], name: "index_bookings_on_venue_id"
  end

  create_table "digital_codes", force: :cascade do |t|
    t.string "name"
    t.string "password"
    t.bigint "venue_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["venue_id"], name: "index_digital_codes_on_venue_id"
  end

  create_table "families", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "venues_count", default: 0
    t.integer "days_for_approval"
    t.bigint "creator_id"
    t.integer "plan", default: 0
    t.date "plan_deadline"
    t.index ["creator_id"], name: "index_families_on_creator_id"
  end

  create_table "family_links", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "family_id"
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
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["venue_id"], name: "index_home_services_on_venue_id"
  end

  create_table "invitations", force: :cascade do |t|
    t.bigint "sender_id"
    t.bigint "receiver_id"
    t.bigint "family_id"
    t.string "email", default: "", null: false
    t.string "token"
    t.integer "status", default: 0
    t.datetime "last_send_at"
    t.integer "send_count", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["family_id"], name: "index_invitations_on_family_id"
    t.index ["receiver_id"], name: "index_invitations_on_receiver_id"
    t.index ["sender_id"], name: "index_invitations_on_sender_id"
  end

  create_table "keys", force: :cascade do |t|
    t.string "name"
    t.bigint "owner_id"
    t.bigint "venue_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["owner_id"], name: "index_keys_on_owner_id"
    t.index ["venue_id"], name: "index_keys_on_venue_id"
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "booking_id"
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["booking_id"], name: "index_messages_on_booking_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "networks", force: :cascade do |t|
    t.string "name"
    t.string "password"
    t.bigint "venue_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["venue_id"], name: "index_networks_on_venue_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "notification_type"
    t.string "description"
    t.string "url"
    t.integer "status", default: 0
    t.bigint "user_id"
    t.bigint "family_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["family_id"], name: "index_notifications_on_family_id"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "question_and_answers", force: :cascade do |t|
    t.string "question"
    t.string "answer"
    t.integer "status", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "team_members", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "function"
    t.integer "status", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "current_family_id"
    t.string "phone"
    t.string "address"
    t.hstore "current_venue_id", default: {}
    t.integer "status", default: 0
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.integer "plan", default: 0
    t.date "plan_deadline"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["current_venue_id"], name: "index_users_on_current_venue_id", using: :gin
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
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
    t.boolean "with_network", default: false
    t.boolean "with_digital_code", default: false
    t.boolean "with_home_service", default: false
    t.text "comment"
    t.boolean "editable_for_others", default: true
    t.bigint "creator_id"
    t.bigint "family_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "single_beds_count", default: 0
    t.integer "double_beds_count", default: 0
    t.integer "baby_beds_count", default: 0
    t.index ["creator_id"], name: "index_venues_on_creator_id"
    t.index ["family_id"], name: "index_venues_on_family_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
end
