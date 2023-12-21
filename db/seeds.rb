
puts "Cleaning DB..."
StructureBuilt.destroy_all
ResearchLevel.destroy_all
DefenseBuilt.destroy_all
Structure.destroy_all
Research.destroy_all
Defense.destroy_all
Unit.destroy_all
Battle.destroy_all
Town.destroy_all
Message.destroy_all
Chatroom.destroy_all
User.destroy_all

puts "Creating users..."
User.new(username: "Rigueur", password: "123456", email: "rigueur@exemple.com", nickname: "Rigueur", level: 5, experience: 160, energy:80, avatar_url: "m-scout-1.png").save!
User.new(username: "Naomi", email: "naomi@exemple.com", nickname: "naomi", level: 3, experience: 15, energy: 35,  password: "pipicaca", avatar_url: "f-knight-2.png").save!
User.new(username: "Pierre", email: "pierre@exemple.com", nickname: "pierre", level: 2, experience: 10, energy: 20, password: "123456", avatar_url: "m-knight-2.png").save!

puts "Creating chatrooms..."
Chatroom.new(name: "General").save!

puts "Creating structures..."
10.times do |index|
  Structure.new(name: "Fields", image_url: "fields-#{index % 3 + 1}.png", level: index, wood_cost: 15 * index, stone_cost: 20 * index, gold_cost: 5 * index, upgrade_time: 2 * index, wood_production: 0, stone_production: 0, gold_production: 0, food_production: 5 * index).save!
  Structure.new(name: "Sawmill", image_url: "sawmill-#{index % 3 + 1}.png", level: index, wood_cost: 25 * index, stone_cost: 10 * index, gold_cost: 5 * index, upgrade_time: 2 * index, wood_production: 5 * index, stone_production: 0, gold_production: 0, food_production: 0).save!
  Structure.new(name: "Mines", image_url: "mines-#{index % 4 + 1}.png", level: index, wood_cost: 25 * index, stone_cost: 20 * index, gold_cost: 8 * index, upgrade_time: 2 * index, wood_production: 0, stone_production: 5 * index, gold_production: 0, food_production: 0).save!
  Structure.new(name: "Market", image_url: "market-#{index % 3 + 1}.png", level: index, wood_cost: 20 * index, stone_cost: 25 * index, gold_cost: 10 * index, upgrade_time: 2 * index, wood_production: 0, stone_production: 0, gold_production: 5 * index, food_production: 0).save!
end
index = 0

puts "Creating researches..."
10.times do |index|
  Research.new(name: "Forge", image_url: "forge-#{index % 4 + 1}.png", level: index, wood_cost: 25, stone_cost: 10, gold_cost: 5, upgrade_time: 1, effect: "Recruit and train armored units").save!
  Research.new(name: "Barracks", image_url: "barracks-#{index % 3 + 1}.png", level: index, wood_cost: 25, stone_cost: 10, gold_cost: 5, upgrade_time: 1, effect: "Recruit and train units").save!
  Research.new(name: "Magic Institut", image_url: "magic-institut-#{index % 4 + 1}.png", level: index, wood_cost: 25, stone_cost: 10, gold_cost: 5, upgrade_time: 1, effect: "Recruit and train magic units").save!
  Research.new(name: "Monster Stable", image_url: "monster-stable-#{index % 2 + 1}.png", level: index, wood_cost: 25, stone_cost: 10, gold_cost: 5, upgrade_time: 1, effect: "Recruit and train monsters").save!
end
index = 0

puts "Creating defenses..."
10.times do |index|
  Defense.new(name: "Walls", image_url: "walls-#{index % 2 + 1}.png", level: index, wood_cost: 25, stone_cost: 10, gold_cost: 5, upgrade_time: 1, effect: "nothing").save!
  Defense.new(name: "Traps", image_url: "traps-#{index % 2 + 1}.png", level: index, wood_cost: 25, stone_cost: 10, gold_cost: 5, upgrade_time: 1, effect: "nothing").save!
  Defense.new(name: "Watchtower", image_url: "watchtower-#{index % 3 + 1}.png", level: index, wood_cost: 25, stone_cost: 10, gold_cost: 5, upgrade_time: 1, effect: "nothing").save!
  Defense.new(name: "Magic Barrier", image_url: "magic-barrier-1.png", level: index, wood_cost: 25, stone_cost: 10, gold_cost: 5, upgrade_time: 1, effect: "nothing").save!
end
index = 0

puts "Creating towns..."
Town.new(user_id: User.find_by(username: "Rigueur").id, name: "Agrabah", coordinates: "1,1", image_url: "desert-base-2.png", wood_quantity: 630, stone_quantity: 850, gold_quantity: 720, food_quantity: 430, research_ongoing: false, construction_ongoing: false, defense_ongoing: false).save!
Town.new(user_id: User.find_by(username: "Naomi").id, name: "Far Far Away", coordinates: "1,1", image_url: "forest-base-2.png", wood_quantity: 100, stone_quantity: 100, gold_quantity: 100, food_quantity: 100, research_ongoing: false, construction_ongoing: false, defense_ongoing: false).save!
Town.new(user_id: User.find_by(username: "Pierre").id, name: "Biot", coordinates: "1,1", image_url: "plain-base-2.png", wood_quantity: 2540, stone_quantity: 2850, gold_quantity: 2100, food_quantity: 4500, research_ongoing: false, construction_ongoing: false, defense_ongoing: false).save!

puts "Cleaning structure_builts..."
StructureBuilt.where(town_id: Town.find_by(name: "Agrabah").id).destroy_all

puts "Creating structure_builts..."
StructureBuilt.new(town_id: Town.find_by(name: "Agrabah").id, structure_id: Structure.find_by(name: "Fields", level: 5).id).save!
StructureBuilt.new(town_id: Town.find_by(name: "Agrabah").id, structure_id: Structure.find_by(name: "Sawmill", level: 7).id).save!
StructureBuilt.new(town_id: Town.find_by(name: "Agrabah").id, structure_id: Structure.find_by(name: "Mines", level: 4).id).save!
StructureBuilt.new(town_id: Town.find_by(name: "Agrabah").id, structure_id: Structure.find_by(name: "Market", level: 8).id).save!

puts "Cleaning research_levels..."
ResearchLevel.where(town_id: Town.find_by(name: "Agrabah").id).destroy_all

puts "Creating research_levels..."
ResearchLevel.new(town_id: Town.find_by(name: "Agrabah").id, research_id: Research.find_by(name: "Forge", level: 6).id).save!
ResearchLevel.new(town_id: Town.find_by(name: "Agrabah").id, research_id: Research.find_by(name: "Barracks", level: 7).id).save!
ResearchLevel.new(town_id: Town.find_by(name: "Agrabah").id, research_id: Research.find_by(name: "Magic Institut", level: 4).id).save!
ResearchLevel.new(town_id: Town.find_by(name: "Agrabah").id, research_id: Research.find_by(name: "Monster Stable", level: 5).id).save!

puts "Cleaning defense_builts..."
DefenseBuilt.where(town_id: Town.find_by(name: "Agrabah").id).destroy_all

puts "Creating defense_builts..."
DefenseBuilt.new(town_id: Town.find_by(name: "Agrabah").id, defense_id: Defense.find_by(name: "Walls", level: 6).id).save!
DefenseBuilt.new(town_id: Town.find_by(name: "Agrabah").id, defense_id: Defense.find_by(name: "Traps", level: 4).id).save!
DefenseBuilt.new(town_id: Town.find_by(name: "Agrabah").id, defense_id: Defense.find_by(name: "Watchtower", level: 4).id).save!
DefenseBuilt.new(town_id: Town.find_by(name: "Agrabah").id, defense_id: Defense.find_by(name: "Magic Barrier", level: 5).id).save!

puts "Creating units..."
25.times do
  Archer.new(town_id:Town.find_by(name: "Agrabah").id, level: 1).save!
end
10.times do
  Archer.new(town_id:Town.find_by(name: "Far Far Away").id, level: 1).save!
end

30.times do
  Mage.new(town_id:Town.find_by(name: "Agrabah").id, level: 1).save!
end

Horseman.new(town_id:Town.find_by(name: "Agrabah").id, level: 1).save!

Soldier.new(town_id:Town.find_by(name: "Agrabah").id, level: 1).save!

Wizard.new(town_id:Town.find_by(name: "Agrabah").id, level: 1).save!

Knight.new(town_id:Town.find_by(name: "Agrabah").id, level: 1).save!

Spearman.new(town_id:Town.find_by(name: "Agrabah").id, level: 1).save!

Heavyknight.new(town_id:Town.find_by(name: "Agrabah").id, level: 1).save!

Magicknight.new(town_id:Town.find_by(name: "Agrabah").id, level: 1).save!

Orc.new(town_id:Town.find_by(name: "Agrabah").id, level: 1).save!

Dragon.new(town_id:Town.find_by(name: "Agrabah").id, level: 1).save!
