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

ActiveRecord::Schema[7.0].define(version: 2023_09_05_025224) do
  create_table "categories", force: :cascade do |t|
    t.string "categoryname", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "philosophers", force: :cascade do |t|
    t.string "pfname", null: false
    t.string "plname", null: false
    t.date "pdob", null: false
    t.date "pdod"
    t.text "pbiography"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "quote_categories", force: :cascade do |t|
    t.integer "Quote_id", null: false
    t.integer "Category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["Category_id"], name: "index_quote_categories_on_Category_id"
    t.index ["Quote_id"], name: "index_quote_categories_on_Quote_id"
  end

  create_table "quotes", force: :cascade do |t|
    t.text "quotetext", null: false
    t.text "comment"
    t.boolean "is_public", default: true
    t.date "publicationyear"
    t.integer "user_id", null: false
    t.integer "philosopher_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["philosopher_id"], name: "index_quotes_on_philosopher_id"
    t.index ["user_id"], name: "index_quotes_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "ufname", null: false
    t.string "ulname", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.boolean "is_admin", default: false
    t.string "status", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "quote_categories", "Categories"
  add_foreign_key "quote_categories", "Quotes"
  add_foreign_key "quotes", "philosophers"
  add_foreign_key "quotes", "users"
end
