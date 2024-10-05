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

ActiveRecord::Schema[7.0].define(version: 2024_10_05_113822) do
  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.integer "resource_id"
    t.string "author_type"
    t.integer "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "bookings", force: :cascade do |t|
    t.integer "user_id"
    t.integer "car_id"
    t.integer "variant_id"
    t.integer "status", default: 0
    t.datetime "booking_date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "brands", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cars", force: :cascade do |t|
    t.string "name"
    t.string "brand_id"
    t.string "body_type"
    t.string "car_types"
    t.date "launch_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dealers", force: :cascade do |t|
    t.string "name"
    t.integer "brand_id"
    t.string "city"
    t.string "address"
    t.string "contact_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "features", force: :cascade do |t|
    t.integer "car_id"
    t.integer "variant_id"
    t.string "city_mileage"
    t.string "fuel_type"
    t.integer "engine_displacement"
    t.integer "no_of_cylinders"
    t.string "max_power"
    t.string "max_torque"
    t.integer "seating_capacity"
    t.string "transmission_type"
    t.integer "boot_space"
    t.integer "fuel_tank_capacity"
    t.string "body_type"
    t.integer "ground_clearance_unladen"
    t.boolean "power_steering"
    t.boolean "abs"
    t.boolean "air_conditioner"
    t.boolean "driver_airbag"
    t.boolean "passenger_airbag"
    t.boolean "automatic_climate_control"
    t.boolean "alloy_wheels"
    t.boolean "multi_function_steering_wheel"
    t.boolean "engine_start_stop_button"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "user_id"
    t.integer "booking_id"
    t.text "message", null: false
    t.boolean "read", default: false
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
  end

  create_table "offers", force: :cascade do |t|
    t.string "offer_name"
    t.decimal "discount"
    t.date "start_date"
    t.date "end_date"
    t.integer "feature_id"
    t.integer "car_id"
    t.integer "variant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "plans", force: :cascade do |t|
    t.string "name"
    t.integer "duration"
    t.float "price"
    t.text "details"
    t.integer "plan_type"
    t.integer "months"
    t.decimal "price_monthly", precision: 10, scale: 2
    t.decimal "price_yearly", precision: 10, scale: 2
    t.integer "limit"
    t.integer "limit_type"
    t.boolean "discount", default: false
    t.string "discount_type"
    t.integer "discount_percentage", default: 0
    t.text "benefits"
    t.boolean "coming_soon", default: false
    t.boolean "active", default: true
    t.boolean "available", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "rating"
    t.text "comment"
    t.integer "user_id"
    t.integer "car_id"
    t.integer "variant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subscriptions", force: :cascade do |t|
    t.integer "plan_id"
    t.integer "user_id"
    t.datetime "started_at"
    t.datetime "expires_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "variants", force: :cascade do |t|
    t.string "variant"
    t.string "price"
    t.string "colour"
    t.integer "car_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "wishlists", force: :cascade do |t|
    t.integer "user_id"
    t.integer "car_id"
    t.integer "variant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
