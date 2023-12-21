
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
User.new(username: "Rigueur", password: "123456", email: "rigueur@exemple.com", nickname: "Rigueur", level: 18, experience: 400, energy:170, avatar_url: "m-scout-1.png").save!
User.new(username: "Naomi", email: "naomi@exemple.com", nickname: "Naomi", level: 3, experience: 15, energy: 35,  password: "123456", avatar_url: "f-knight-2.png").save!
User.new(username: "Pierre", email: "pierre@exemple.com", nickname: "Pierre", level: 7, experience: 10, energy: 20, password: "123456", avatar_url: "m-knight-2.png").save!
User.new(username: "Zineb", email: "zineb@exemple.com", nickname: "Zizou", level: 1, experience: 5, energy: 10, password: "123456", avatar_url: "elf-scout-1.png").save!
User.new(username: "Baptiste", email: "baptiste@exemple.com", nickname: "Bat-Bat", level: 15, experience: 50, energy: 100, password: "123456", avatar_url: "m-knight-1.png").save!
User.new(username: "Fabrice", email: "fabrice@exemple.com", nickname: "Fab-Fab", level: 8, experience: 40, energy: 80, password: "123456", avatar_url: "m-scout-2.png").save!
User.new(username: "Edouard", email: "edouard@exemple.com", nickname: "Dou-Dou", level: 5, experience: 5, energy: 10, password: "123456", avatar_url: "f-knight-1.png").save!

puts "Creating chatrooms..."
Chatroom.new(name: "General").save!

puts "Creating structures..."
10.times do |index|
  Structure.new(name: "Fields", image_url: "fields-#{index % 3 + 1}.png", level: index, wood_cost: 15 + 10 * index, stone_cost: 20 * index, gold_cost: 5 * index, upgrade_time: 2 * index, wood_production: 0, stone_production: 0, gold_production: 0, food_production: 5 * index).save!
  Structure.new(name: "Sawmill", image_url: "sawmill-#{index % 3 + 1}.png", level: index, wood_cost: 25 * index, stone_cost: 10 * index, gold_cost: 5 * index, upgrade_time: 2 * index, wood_production: 5 * index, stone_production: 0, gold_production: 0, food_production: 0).save!
  Structure.new(name: "Mines", image_url: "mines-#{index % 4 + 1}.png", level: index, wood_cost: 25 * index, stone_cost: 20 * index, gold_cost: 8 * index, upgrade_time: 2 * index, wood_production: 0, stone_production: 5 * index, gold_production: 0, food_production: 0).save!
  Structure.new(name: "Market", image_url: "market-#{index % 3 + 1}.png", level: index, wood_cost: 20 * index, stone_cost: 25 * index, gold_cost: 10 * index, upgrade_time: 2 * index, wood_production: 0, stone_production: 0, gold_production: 5 * index, food_production: 0).save!
end
index = 0

puts "Creating researches..."
10.times do |index|
  Research.new(name: "Forge", image_url: "forge-#{index % 4 + 1}.png", level: index, wood_cost: 25 + 10 * index, stone_cost: 40 + 25 * index, gold_cost: 30 + 20 * index, upgrade_time: 4 + 3 * index, effect: "Recruit and train armored units").save!
  Research.new(name: "Barracks", image_url: "barracks-#{index % 3 + 1}.png", level: index, wood_cost: 30 + 15 * index, stone_cost: 30 + 15 * index, gold_cost: 20 + 15 * index, upgrade_time: 4 + 3 * index, effect: "Recruit and train units").save!
  Research.new(name: "Magic Institut", image_url: "magic-institut-#{index % 4 + 1}.png", level: index, wood_cost: 20 + 10 * index, stone_cost: 20 + 10 * index, gold_cost: 50 + 25 * index, upgrade_time: 4 + 3 * index, effect: "Recruit and train magic units").save!
  Research.new(name: "Monster Stable", image_url: "monster-stable-#{index % 2 + 1}.png", level: index, wood_cost: 40 + 35 * index, stone_cost: 30 + 25 * index, gold_cost: 40 + 25 * index, upgrade_time: 4 + 3 * index, effect: "Recruit and train monsters").save!
end
index = 0

puts "Creating defenses..."
10.times do |index|
  Defense.new(name: "Walls", image_url: "walls-#{index % 2 + 1}.png", level: index, wood_cost: 15 + 15 * index, stone_cost: 30 + 30 * index, gold_cost: 15 + 15 * index, upgrade_time: 5 + 2 * index, effect: "Boost Units' Hp").save!
  Defense.new(name: "Traps", image_url: "traps-#{index % 2 + 1}.png", level: index, wood_cost: 25 + 20 * index, stone_cost: 20 + 15 * index, gold_cost: 20 + 15 * index, upgrade_time: 5 + 2 * index, effect: "Boost Units' Atk").save!
  Defense.new(name: "Watchtower", image_url: "watchtower-#{index % 3 + 1}.png", level: index, wood_cost: 35 + 25 * index, stone_cost: 25 + 20 * index, gold_cost: 15 + 10 * index, upgrade_time: 6 + 3 * index, effect: "Lower stealth").save!
  Defense.new(name: "Magic Barrier", image_url: "magic-barrier-1.png", level: index, wood_cost: 20 + 30 * index, stone_cost: 20 + 30 * index, gold_cost: 50 + 30 * index, upgrade_time: 10 + 5 * index, effect: "Boost Units' Hp").save!
end
index = 0

puts "Creating towns..."
Town.new(user_id: User.find_by(username: "Rigueur").id, name: "Agrabah", coordinates: "1,1", image_url: "desert-base-2.png", wood_quantity: 630, stone_quantity: 850, gold_quantity: 720, food_quantity: 430, research_ongoing: false, construction_ongoing: false, defense_ongoing: false).save!
Town.new(user_id: User.find_by(username: "Naomi").id, name: "Far Far Away", coordinates: "1,1", image_url: "forest-base-2.png", wood_quantity: 140, stone_quantity: 250, gold_quantity: 80, food_quantity: 120, research_ongoing: false, construction_ongoing: false, defense_ongoing: false).save!
Town.new(user_id: User.find_by(username: "Pierre").id, name: "Biot", coordinates: "1,1", image_url: "plain-base-2.png", wood_quantity: 2540, stone_quantity: 2850, gold_quantity: 2100, food_quantity: 4500, research_ongoing: false, construction_ongoing: false, defense_ongoing: false).save!
Town.new(user_id: User.find_by(username: "Zineb").id, name: "Startway", coordinates: "1,1", image_url: "desert-base-3.png", wood_quantity: 100, stone_quantity: 100, gold_quantity: 100, food_quantity: 100, research_ongoing: false, construction_ongoing: false, defense_ongoing: false).save!
Town.new(user_id: User.find_by(username: "Baptiste").id, name: "Kaamelott", coordinates: "1,1", image_url: "plain-base-4.png", wood_quantity: 100, stone_quantity: 100, gold_quantity: 100, food_quantity: 100, research_ongoing: false, construction_ongoing: false, defense_ongoing: false).save!
Town.new(user_id: User.find_by(username: "Fabrice").id, name: "Sherwood", coordinates: "1,1", image_url: "forest-base-3.png", wood_quantity: 850, stone_quantity: 750, gold_quantity: 400, food_quantity: 600, research_ongoing: false, construction_ongoing: false, defense_ongoing: false).save!
Town.new(user_id: User.find_by(username: "Edouard").id, name: "BasicFit", coordinates: "1,1", image_url: "mountain-base-2.png", wood_quantity: 100, stone_quantity: 100, gold_quantity: 100, food_quantity: 100, research_ongoing: false, construction_ongoing: false, defense_ongoing: false).save!

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
DefenseBuilt.new(town_id: Town.find_by(name: "Agrabah").id, defense_id: Defense.find_by(name: "Walls", level: 3).id).save!
DefenseBuilt.new(town_id: Town.find_by(name: "Agrabah").id, defense_id: Defense.find_by(name: "Traps", level: 4).id).save!
DefenseBuilt.new(town_id: Town.find_by(name: "Agrabah").id, defense_id: Defense.find_by(name: "Watchtower", level: 4).id).save!
DefenseBuilt.new(town_id: Town.find_by(name: "Agrabah").id, defense_id: Defense.find_by(name: "Magic Barrier", level: 2).id).save!

puts "Creating units..."
25.times do
  Archer.new(town_id:Town.find_by(name: "Agrabah").id, level: 1).save!
end
30.times do
  Archer.new(town_id:Town.find_by(name: "Sherwood").id, level: 1).save!
end

20.times do
  Mage.new(town_id:Town.find_by(name: "Agrabah").id, level: 1).save!
end
10.times do
  Mage.new(town_id:Town.find_by(name: "Sherwood").id, level: 1).save!
end

12.times do
  Horseman.new(town_id:Town.find_by(name: "Agrabah").id, level: 1).save!
end

10.times do
  Soldier.new(town_id:Town.find_by(name: "Agrabah").id, level: 1).save!
  Soldier.new(town_id:Town.find_by(name: "Agrabah").id, level: 2).save!
end
5.times do
  Soldier.new(town_id:Town.find_by(name: "Sherwood").id, level: 1).save!
end

8.times do
  Wizard.new(town_id:Town.find_by(name: "Agrabah").id, level: 1).save!
end

9.times do
  Knight.new(town_id:Town.find_by(name: "Agrabah").id, level: 1).save!
  Spearman.new(town_id:Town.find_by(name: "Agrabah").id, level: 1).save!
  2.times do
    Knight.new(town_id:Town.find_by(name: "Kaamelott").id, level: 1).save!
    Spearman.new(town_id:Town.find_by(name: "Kaamelott").id, level: 1).save!
  end
end

3.times do
  Heavyknight.new(town_id:Town.find_by(name: "Agrabah").id, level: 1).save!
end
Heavyknight.new(town_id:Town.find_by(name: "Agrabah").id, level: 2).save!
8.times do
  Heavyknight.new(town_id:Town.find_by(name: "Kaamelott").id, level: 1).save!
end

5.times do
  Magicknight.new(town_id:Town.find_by(name: "Agrabah").id, level: 1).save!
  Magicknight.new(town_id:Town.find_by(name: "Kaamelott").id, level: 2).save!
end
Magicknight.new(town_id:Town.find_by(name: "Agrabah").id, level: 2).save!

2.times do
  Orc.new(town_id:Town.find_by(name: "Agrabah").id, level: 1).save!
end
9.times do
  Orc.new(town_id:Town.find_by(name: "Kaamelott").id, level: 1).save!
end

Dragon.new(town_id:Town.find_by(name: "Agrabah").id, level: 1).save!
4.times do
  Dragon.new(town_id:Town.find_by(name: "Kaamelott").id, level: 2).save!
end
