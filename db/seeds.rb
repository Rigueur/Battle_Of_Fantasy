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
Homebase.destroy_all
User.destroy_all

puts "Creating users..."
User.new(username: "Rigueur", password: "123456", email: "rigueur@exemple.com", nickname: "Rigueur", level: 5, experience: 50, energy:20).save!
User.new(username: "Naomi", email: "naomi@exemple.com", nickname: "naomi", level: 3, experience: 15, energy: 35,  password: "pipicaca").save!

puts "Creating structures..."
Structure.new(name: "Fields", image_url: "test", level: 1, wood_cost: 25, stone_cost: 10, gold_cost: 5, upgrade_time: 5, wood_production: 0, stone_production: 0, gold_production: 0, food_production: 5).save!

puts "Creating researches..."
Research.new(name: "Forge", image_url: "test", level: 1, wood_cost: 25, stone_cost: 10, gold_cost: 5, upgrade_time: 5, effect: "nothing").save!

puts "Creating defenses..."
Defense.new(name: "Walls", image_url: "test", level: 1, wood_cost: 25, stone_cost: 10, gold_cost: 5, upgrade_time: 5, effect: "nothing").save!

puts "Creating homebases..."
Homebase.new(user_id: User.first.id, name: "test", coordinates: "1,1", image_url: "test", wood_quantity: "50", stone_quantity: "50", gold_quantity: "50", food_quantity: "50", research_ongoing: false, construction_ongoing: false, defense_ongoing: false).save!
Homebase.new(user_id: User.last.id, name: "Homebase Testing", coordinates: "1,1", wood_quantity: 100, stone_quantity: 100, gold_quantity: 100, food_quantity: 100, research_ongoing: false, construction_ongoing: false, defense_ongoing: false).save!

puts "Creating structure builts..."
StructureBuilt.new(structure_id: Structure.first.id, homebase_id: Homebase.first.id).save!

puts "Creating research levels..."
ResearchLevel.new(research_id: Research.first.id, homebase_id: Homebase.first.id).save!

puts "Creating defense builts..."
DefenseBuilt.new(defense_id: Defense.first.id, homebase_id: Homebase.first.id).save!
