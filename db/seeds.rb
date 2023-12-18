
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
Town.destroy_all
User.destroy_all

puts "Creating users..."
User.new(username: "Rigueur", password: "123456", email: "rigueur@exemple.com", nickname: "Rigueur", level: 5, experience: 50, energy:20).save!
User.new(username: "Naomi", email: "naomi@exemple.com", nickname: "naomi", level: 3, experience: 15, energy: 35,  password: "pipicaca").save!

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
  Defense.new(name: "Moat", image_url: "test", level: index, wood_cost: 25, stone_cost: 10, gold_cost: 5, upgrade_time: 1, effect: "nothing").save!
end
index = 0


puts "Creating towns..."
Town.new(user_id: User.first.id, name: "test", coordinates: "1,1", image_url: "test", wood_quantity: 500, stone_quantity: 500, gold_quantity: 500, food_quantity: 500, research_ongoing: false, construction_ongoing: false, defense_ongoing: false).save!
Town.new(user_id: User.last.id, name: "Town Testing", coordinates: "1,1", wood_quantity: 100, stone_quantity: 100, gold_quantity: 100, food_quantity: 100, research_ongoing: false, construction_ongoing: false, defense_ongoing: false).save!

puts "Creating structure builts..."
StructureBuilt.new(structure_id: Structure.find_by(name: "Fields", level: 1).id, town_id: Town.first.id).save!
StructureBuilt.new(structure_id: Structure.find_by(name: "Sawmill", level: 1).id, town_id: Town.first.id).save!
StructureBuilt.new(structure_id: Structure.find_by(name: "Mine", level: 1).id, town_id: Town.first.id).save!
StructureBuilt.new(structure_id: Structure.find_by(name: "Market", level: 1).id, town_id: Town.first.id).save!

puts "Creating research levels..."
ResearchLevel.new(research_id: Research.find_by(name: "Forge", level: 0).id, town_id: Town.first.id).save!
ResearchLevel.new(research_id: Research.find_by(name: "Barracks", level: 0).id, town_id: Town.first.id).save!
ResearchLevel.new(research_id: Research.find_by(name: "Magic Institut", level: 0).id, town_id: Town.first.id).save!
ResearchLevel.new(research_id: Research.find_by(name: "Monster Stable", level: 0).id, town_id: Town.first.id).save!

puts "Creating defense builts..."
DefenseBuilt.new(defense_id: Defense.find_by(name: "Walls", level: 0).id, town_id: Town.first.id).save!
DefenseBuilt.new(defense_id: Defense.find_by(name: "Towers", level: 0).id, town_id: Town.first.id).save!
DefenseBuilt.new(defense_id: Defense.find_by(name: "Traps", level: 0).id, town_id: Town.first.id).save!
DefenseBuilt.new(defense_id: Defense.find_by(name: "Moat", level: 0).id, town_id: Town.first.id).save!

puts "Creating archers..."
Archer.new(name: "Archer", town_id:Town.last.id, level: 1, hp: 10, armor_type: "light", attack: 5, attack_type: "physical", speed: 5, stealth: 5, gold_recruit_cost: 5, food_recruit_cost: 5, energy_recruit_cost: 5, gold_train_cost: 5, food_train_cost: 5, energy_train_cost: 5, enrolled: false).save!
Archer.new(name: "Archer 2", town_id:Town.first.id, level: 1, hp: 10, armor_type: "light", attack: 5, attack_type: "physical", speed: 5, stealth: 5, gold_recruit_cost: 5, food_recruit_cost: 5, energy_recruit_cost: 5, gold_train_cost: 5, food_train_cost: 5, energy_train_cost: 5, enrolled: false).save!

puts "Creatings mages..."
Mage.new(name: "Mage", town_id:Town.last.id, level: 1, hp: 10, armor_type: "light", attack: 5, attack_type: "magic", speed: 5, stealth: 5, gold_recruit_cost: 5, food_recruit_cost: 5, energy_recruit_cost: 5, gold_train_cost: 5, food_train_cost: 5, energy_train_cost: 5, enrolled: false).save!

Horseman.new(name: "Horseman", town_id:Town.last.id, level: 1, hp: 10, armor_type: "light", attack: 5, attack_type: "magic", speed: 5, stealth: 5, gold_recruit_cost: 5, food_recruit_cost: 5, energy_recruit_cost: 5, gold_train_cost: 5, food_train_cost: 5, energy_train_cost: 5, enrolled: false).save!

Soldier.new(name: "Soldier", town_id:Town.last.id, level: 1, hp: 10, armor_type: "light", attack: 5, attack_type: "magic", speed: 5, stealth: 5, gold_recruit_cost: 5, food_recruit_cost: 5, energy_recruit_cost: 5, gold_train_cost: 5, food_train_cost: 5, energy_train_cost: 5, enrolled: false).save!

Wizard.new(name: "Wizard", town_id:Town.last.id, level: 1, hp: 10, armor_type: "light", attack: 5, attack_type: "magic", speed: 5, stealth: 5, gold_recruit_cost: 5, food_recruit_cost: 5, energy_recruit_cost: 5, gold_train_cost: 5, food_train_cost: 5, energy_train_cost: 5, enrolled: false).save!
