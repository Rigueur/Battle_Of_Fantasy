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

ActiveRecord::Schema[7.1].define(version: 2023_12_14_093757) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "archers", force: :cascade do |t|
    t.bigint "town_id", null: false
    t.text "name"
    t.text "image_url"
    t.text "role"
    t.integer "level"
    t.integer "hp"
    t.text "armor_type"
    t.integer "attack"
    t.text "attack_type"
    t.integer "speed"
    t.integer "stealth"
    t.integer "gold_recruit_cost"
    t.integer "food_recruit_cost"
    t.integer "energy_recruit_cost"
    t.integer "gold_train_cost"
    t.integer "food_train_cost"
    t.string "energy_train_cost"
    t.boolean "enrolled"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["town_id"], name: "index_archers_on_town_id"
  end

  create_table "battles", force: :cascade do |t|
    t.integer "energy_cost"
    t.text "result"
    t.bigint "attacking_base_id", null: false
    t.bigint "defending_base_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["attacking_base_id"], name: "index_battles_on_attacking_base_id"
    t.index ["defending_base_id"], name: "index_battles_on_defending_base_id"
  end

  create_table "defense_builts", force: :cascade do |t|
    t.bigint "town_id", null: false
    t.bigint "defense_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["defense_id"], name: "index_defense_builts_on_defense_id"
    t.index ["town_id"], name: "index_defense_builts_on_town_id"
  end

  create_table "defenses", force: :cascade do |t|
    t.text "name"
    t.text "image_url"
    t.integer "level"
    t.integer "wood_cost"
    t.integer "stone_cost"
    t.integer "gold_cost"
    t.text "upgrade_time"
    t.text "effect"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "horsemen", force: :cascade do |t|
    t.bigint "town_id", null: false
    t.text "name"
    t.text "image_url"
    t.text "role"
    t.integer "level"
    t.integer "hp"
    t.text "armor_type"
    t.integer "attack"
    t.text "attack_type"
    t.integer "speed"
    t.integer "stealth"
    t.integer "gold_recruit_cost"
    t.integer "food_recruit_cost"
    t.integer "energy_recruit_cost"
    t.integer "gold_train_cost"
    t.integer "food_train_cost"
    t.string "energy_train_cost"
    t.boolean "enrolled"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["town_id"], name: "index_horsemen_on_town_id"
  end

  create_table "mages", force: :cascade do |t|
    t.bigint "town_id", null: false
    t.text "name"
    t.text "image_url"
    t.text "role"
    t.integer "level"
    t.integer "hp"
    t.text "armor_type"
    t.integer "attack"
    t.text "attack_type"
    t.integer "speed"
    t.integer "stealth"
    t.integer "gold_recruit_cost"
    t.integer "food_recruit_cost"
    t.integer "energy_recruit_cost"
    t.integer "gold_train_cost"
    t.integer "food_train_cost"
    t.string "energy_train_cost"
    t.boolean "enrolled"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["town_id"], name: "index_mages_on_town_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "content"
    t.datetime "send_time"
    t.boolean "read"
    t.bigint "sender_id", null: false
    t.bigint "receiver_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["receiver_id"], name: "index_messages_on_receiver_id"
    t.index ["sender_id"], name: "index_messages_on_sender_id"
  end

  create_table "research_levels", force: :cascade do |t|
    t.bigint "town_id", null: false
    t.bigint "research_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["research_id"], name: "index_research_levels_on_research_id"
    t.index ["town_id"], name: "index_research_levels_on_town_id"
  end

  create_table "researches", force: :cascade do |t|
    t.text "name"
    t.text "image_url"
    t.integer "level"
    t.integer "wood_cost"
    t.integer "stone_cost"
    t.integer "gold_cost"
    t.text "upgrade_time"
    t.text "effect"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "soldiers", force: :cascade do |t|
    t.bigint "town_id", null: false
    t.text "name"
    t.text "image_url"
    t.text "role"
    t.integer "level"
    t.integer "hp"
    t.text "armor_type"
    t.integer "attack"
    t.text "attack_type"
    t.integer "speed"
    t.integer "stealth"
    t.integer "gold_recruit_cost"
    t.integer "food_recruit_cost"
    t.integer "energy_recruit_cost"
    t.integer "gold_train_cost"
    t.integer "food_train_cost"
    t.string "energy_train_cost"
    t.boolean "enrolled"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["town_id"], name: "index_soldiers_on_town_id"
  end

  create_table "structure_builts", force: :cascade do |t|
    t.bigint "town_id", null: false
    t.bigint "structure_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["structure_id"], name: "index_structure_builts_on_structure_id"
    t.index ["town_id"], name: "index_structure_builts_on_town_id"
  end

  create_table "structures", force: :cascade do |t|
    t.text "name"
    t.text "image_url"
    t.integer "level"
    t.integer "wood_cost"
    t.integer "stone_cost"
    t.integer "gold_cost"
    t.text "upgrade_time"
    t.integer "wood_production"
    t.integer "stone_production"
    t.integer "gold_production"
    t.integer "food_production"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "towns", force: :cascade do |t|
    t.text "name"
    t.text "coordinates"
    t.text "image_url"
    t.integer "wood_quantity"
    t.integer "stone_quantity"
    t.integer "gold_quantity"
    t.integer "food_quantity"
    t.boolean "research_ongoing"
    t.datetime "research_end_time"
    t.boolean "construction_ongoing"
    t.datetime "construction_end_time"
    t.boolean "defense_ongoing"
    t.datetime "defense_end_time"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "resources_updated_at"
    t.index ["user_id"], name: "index_towns_on_user_id"
  end

  create_table "units", force: :cascade do |t|
    t.bigint "town_id", null: false
    t.text "name"
    t.text "image_url"
    t.text "role"
    t.integer "level"
    t.integer "hp"
    t.text "armor_type"
    t.integer "attack"
    t.text "attack_type"
    t.integer "speed"
    t.integer "stealth"
    t.integer "gold_recruit_cost"
    t.integer "food_recruit_cost"
    t.integer "energy_recruit_cost"
    t.integer "gold_train_cost"
    t.integer "food_train_cost"
    t.string "energy_train_cost"
    t.boolean "enrolled"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["town_id"], name: "index_units_on_town_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.string "avatar_url"
    t.string "nickname"
    t.integer "level"
    t.integer "experience"
    t.integer "energy"
    t.datetime "energy_updated_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "wizards", force: :cascade do |t|
    t.bigint "town_id", null: false
    t.text "name"
    t.text "image_url"
    t.text "role"
    t.integer "level"
    t.integer "hp"
    t.text "armor_type"
    t.integer "attack"
    t.text "attack_type"
    t.integer "speed"
    t.integer "stealth"
    t.integer "gold_recruit_cost"
    t.integer "food_recruit_cost"
    t.integer "energy_recruit_cost"
    t.integer "gold_train_cost"
    t.integer "food_train_cost"
    t.string "energy_train_cost"
    t.boolean "enrolled"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["town_id"], name: "index_wizards_on_town_id"
  end

  add_foreign_key "archers", "towns"
  add_foreign_key "battles", "users", column: "attacking_base_id"
  add_foreign_key "battles", "users", column: "defending_base_id"
  add_foreign_key "defense_builts", "defenses"
  add_foreign_key "defense_builts", "towns"
  add_foreign_key "horsemen", "towns"
  add_foreign_key "mages", "towns"
  add_foreign_key "messages", "users", column: "receiver_id"
  add_foreign_key "messages", "users", column: "sender_id"
  add_foreign_key "research_levels", "researches"
  add_foreign_key "research_levels", "towns"
  add_foreign_key "soldiers", "towns"
  add_foreign_key "structure_builts", "structures"
  add_foreign_key "structure_builts", "towns"
  add_foreign_key "towns", "users"
  add_foreign_key "units", "towns"
  add_foreign_key "wizards", "towns"
end
