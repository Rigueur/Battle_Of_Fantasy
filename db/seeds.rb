
# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts "Cleaning DB..."
StructureBuilt.destroy_all
ResearchLevel.destroy_all
DefenseBuilt.destroy_all
Structure.destroy_all
Research.destroy_all
Defense.destroy_all
Archer.destroy_all
Mage.destroy_all
Horseman.destroy_all
Soldier.destroy_all
Wizard.destroy_all
Battle.destroy_all
Town.destroy_all
User.destroy_all

puts "Creating users..."
User.new(username: "Rigueur", password: "123456", email: "rigueur@exemple.com", nickname: "Rigueur", level: 5, experience: 160, energy:80).save!
User.new(username: "Naomi", email: "naomi@exemple.com", nickname: "naomi", level: 3, experience: 15, energy: 35,  password: "pipicaca").save!
User.new(username: "Pierre", email: "pierre@exemple.com", nickname: "pierre", level: 2, experience: 10, energy: 20, password: "123456").save!

puts "Creating structures..."
10.times do |index|
  Structure.new(name: "Fields", image_url: "test", level: index, wood_cost: 25 * index, stone_cost: 10 * index, gold_cost: 5 * index, upgrade_time: 1, wood_production: 0, stone_production: 0, gold_production: 0, food_production: 5 * index).save!
  Structure.new(name: "Sawmill", image_url: "test", level: index, wood_cost: 25 * index, stone_cost: 10 * index, gold_cost: 5 * index, upgrade_time: 1 * index, wood_production: 5 * index, stone_production: 0, gold_production: 0, food_production: 0).save!
  Structure.new(name: "Mine", image_url: "test", level: index, wood_cost: 25 * index, stone_cost: 10 * index, gold_cost: 5 * index, upgrade_time: 1 * index, wood_production: 0, stone_production: 5 * index, gold_production: 0, food_production: 0).save!
  Structure.new(name: "Market", image_url: "test", level: index, wood_cost: 25 * index, stone_cost: 10 * index, gold_cost: 5 * index, upgrade_time: 1 * index, wood_production: 0, stone_production: 0, gold_production: 5 * index, food_production: 0).save!
end
index = 0

puts "Creating researches..."
10.times do |index|
  Research.new(name: "Forge", image_url: "test", level: index, wood_cost: 25, stone_cost: 10, gold_cost: 5, upgrade_time: 1, effect: "nothing").save!
  Research.new(name: "Barracks", image_url: "test", level: index, wood_cost: 25, stone_cost: 10, gold_cost: 5, upgrade_time: 1, effect: "nothing").save!
  Research.new(name: "Magic Institut", image_url: "test", level: index, wood_cost: 25, stone_cost: 10, gold_cost: 5, upgrade_time: 1, effect: "nothing").save!
  Research.new(name: "Monster Stable", image_url: "test", level: index, wood_cost: 25, stone_cost: 10, gold_cost: 5, upgrade_time: 1, effect: "nothing").save!
end
index = 0


puts "Creating defenses..."
10.times do |index|
  Defense.new(name: "Walls", image_url: "test", level: index, wood_cost: 25, stone_cost: 10, gold_cost: 5, upgrade_time: 1, effect: "nothing").save!
  Defense.new(name: "Towers", image_url: "test", level: index, wood_cost: 25, stone_cost: 10, gold_cost: 5, upgrade_time: 1, effect: "nothing").save!
  Defense.new(name: "Traps", image_url: "test", level: index, wood_cost: 25, stone_cost: 10, gold_cost: 5, upgrade_time: 1, effect: "nothing").save!
  Defense.new(name: "Magic Barrier", image_url: "test", level: index, wood_cost: 25, stone_cost: 10, gold_cost: 5, upgrade_time: 1, effect: "nothing").save!
end
index = 0


puts "Creating towns..."
Town.new(user_id: User.find_by(username: "Rigueur").id, name: "Agrabah", coordinates: "1,1", image_url: "test", wood_quantity: 500, stone_quantity: 500, gold_quantity: 500, food_quantity: 500, research_ongoing: false, construction_ongoing: false, defense_ongoing: false).save!
Town.new(user_id: User.find_by(username: "Naomi").id, name: "Far Far Away", coordinates: "1,1", wood_quantity: 100, stone_quantity: 100, gold_quantity: 100, food_quantity: 100, research_ongoing: false, construction_ongoing: false, defense_ongoing: false).save!
Town.new(user_id: User.find_by(username: "Pierre").id, name: "Biot", coordinates: "1,1", wood_quantity: 2500, stone_quantity: 2500, gold_quantity: 2500, food_quantity: 2500, research_ongoing: false, construction_ongoing: false, defense_ongoing: false).save!

puts "Creating archers..."
25.times do
  Archer.new(town_id:Town.find_by(name: "Agrabah").id, level: 1).save!
end
10.times do
  Archer.new(town_id:Town.find_by(name: "Far Far Away").id, level: 1).save!
end

puts "Creating mages..."
Mage.new(town_id:Town.find_by(name: "Agrabah").id, level: 1).save!

puts "Creating horsemen..."
Horseman.new(town_id:Town.find_by(name: "Agrabah").id, level: 1).save!

puts "Creating soldiers..."
Soldier.new(town_id:Town.find_by(name: "Agrabah").id, level: 1).save!

puts "Creating wizards..."
Wizard.new(town_id:Town.find_by(name: "Agrabah").id, level: 1).save!
