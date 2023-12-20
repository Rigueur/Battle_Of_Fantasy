class Unit < ApplicationRecord
  attr_accessor :qty
  belongs_to :town
  validates :level, presence: true

  before_create :set_role
  after_create :save_stats

  def set_role
    self.role = self.class.name.downcase
  end

  def self.roles
    self.distinct.pluck(:role)
  end

  self.roles.each do |role|
    define_singleton_method(role.pluralize.to_sym) do
      self.where(role: role)
    end
  end

  def self.train
    self.where("train_ongoing = true").each do |unit|
      unit.update(
        train_time: unit.train_time - 1
      )
    end
  end

  def self.update_stats
    self.all.each do |unit|
      unit.set_stats
      unit.save
    end
  end

  def save_stats
    self.set_stats
    self.save!
  end

  def set_stats
    unit_stats = case self.role
    when "archer"
    {
      hp: 90 + (10 + 5 * self.level) * self.level,
      armor_type: "light",
      attack: 10 + (2 + 2 * self.level) * self.level,
      attack_type: "physical",
      speed: 8 + (2 + 1 * self.level) * self.level,
      stealth: 8 + (2 + 1 * self.level) * self.level,
      gold_recruit_cost: 6 * self.level,
      food_recruit_cost: 6 * self.level,
      energy_recruit_cost: 1 * self.level,
      gold_train_cost: 10 * self.level,
      food_train_cost: 10 * self.level,
      energy_train_cost: 1 * self.level,
      image_url: self.role + "-1.png"
    }
    when "mage"
    {
      hp: 70 + (10 + 3 * self.level) * self.level,
      armor_type: "light",
      attack: 10 + (2 + 3 * self.level) * self.level,
      attack_type: "magical",
      speed: 5 + (1 + 1 * self.level) * self.level,
      stealth: 5 + 1 * self.level,
      gold_recruit_cost: 5 * self.level,
      food_recruit_cost: 5 * self.level,
      energy_recruit_cost: 1 * self.level,
      gold_train_cost: 12 * self.level,
      food_train_cost: 8 * self.level,
      energy_train_cost: 1 * self.level,
      image_url: self.role + "-#{[self.level, 2].min}.png"
    }
    when "soldier"
    {
      hp: 100 + (10 + 6 * self.level) * self.level,
      armor_type: "medium",
      attack: 10 + (2 + 2 * self.level) * self.level,
      attack_type: "physical",
      speed: 5 + (1 + 1 * self.level) * self.level,
      stealth: 5 + 1 * self.level,
      gold_recruit_cost: 5 * self.level,
      food_recruit_cost: 5 * self.level,
      energy_recruit_cost: 1 * self.level,
      gold_train_cost: 5 * self.level,
      food_train_cost: 10 * self.level,
      energy_train_cost: 1 * self.level,
      image_url: self.role + "-#{[self.level, 3].min}.png"
    }
    when "horseman"
    {
      hp: 120 + (10 + 4 * self.level) * self.level,
      armor_type: "medium",
      attack: 12 + (2 + 2 * self.level) * self.level,
      attack_type: "physical",
      speed: 10 + (2 + 3 * self.level) * self.level,
      stealth: 10 + 2 * self.level,
      gold_recruit_cost: 12 * self.level,
      food_recruit_cost: 15 * self.level,
      energy_recruit_cost: 1 * self.level,
      gold_train_cost: 12 * self.level,
      food_train_cost: 8 * self.level,
      energy_train_cost: 1 * self.level,
      image_url: self.role + "-1.png"
    }
    when "wizard"
    {
      hp: 80 + (10 + 2 * self.level) * self.level,
      armor_type: "light",
      attack: 20 + (2 + 5 * self.level) * self.level,
      attack_type: "magical",
      speed: 5 + (1 + 1 * self.level) * self.level,
      stealth: 5 + 1 * self.level,
      gold_recruit_cost: 15 * self.level,
      food_recruit_cost: 8 * self.level,
      energy_recruit_cost: 1 * self.level,
      gold_train_cost: 20 * self.level,
      food_train_cost: 10 * self.level,
      energy_train_cost: 1 + 1 * self.level,
      image_url: self.role + "-1.png"
    }
    when "knight"
    {
      hp: 150 + (10 + 8 * self.level) * self.level,
      armor_type: "heavy",
      attack: 15 + (2 + 3 * self.level) * self.level,
      attack_type: "physical",
      speed: 5 + (1 + 1 * self.level) * self.level,
      stealth: 5 + 1 * self.level,
      gold_recruit_cost: 15 * self.level,
      food_recruit_cost: 8 * self.level,
      energy_recruit_cost: 1 * self.level,
      gold_train_cost: 20 * self.level,
      food_train_cost: 10 * self.level,
      energy_train_cost: 1 + 1 * self.level,
      image_url: self.role + "-1.png"
    }
    when "spearman"
    {
      hp: 120 + (10 + 4 * self.level) * self.level,
      armor_type: "medium",
      attack: 12 + (2 + 2 * self.level) * self.level,
      attack_type: "physical",
      speed: 5 + (1 + 1 * self.level) * self.level,
      stealth: 5 + 1 * self.level,
      gold_recruit_cost: 12 * self.level,
      food_recruit_cost: 15 * self.level,
      energy_recruit_cost: 1 * self.level,
      gold_train_cost: 12 * self.level,
      food_train_cost: 8 * self.level,
      energy_train_cost: 1 + 1 * self.level,
      image_url: self.role + "-1.png"
    }
    when "heavyknight"
    {
      hp: 200 + (10 + 10 * self.level) * self.level,
      armor_type: "heavy",
      attack: 20 + (2 + 5 * self.level) * self.level,
      attack_type: "physical",
      speed: 5 + 1 * self.level,
      stealth: 5 + 1 * self.level,
      gold_recruit_cost: 40 * self.level,
      food_recruit_cost: 70 * self.level,
      energy_recruit_cost: 4 * self.level,
      gold_train_cost: 40 * self.level,
      food_train_cost: 50 * self.level,
      energy_train_cost: 4 + 2 * self.level,
      image_url: self.role + "-#{[self.level, 2].min}.png"
    }
    when "magicknight"
    {
      hp: 150 + (10 + 8 * self.level) * self.level,
      armor_type: "heavy",
      attack: 25 + (3 + 6 * self.level) * self.level,
      attack_type: "magical",
      speed: 5 + (1 + 1 * self.level) * self.level,
      stealth: 5 + 1 * self.level,
      gold_recruit_cost: 85 * self.level,
      food_recruit_cost: 85 * self.level,
      energy_recruit_cost: 6 * self.level,
      gold_train_cost: 60 * self.level,
      food_train_cost: 40 * self.level,
      energy_train_cost: 5 + 3 * self.level,
      image_url: self.role + "-#{[self.level, 2].min}.png"
    }
    when "orc"
    {
      hp: 150 + (10 + 8 * self.level) * self.level,
      armor_type: "light",
      attack: 15 + (2 + 4 * self.level) * self.level,
      attack_type: "physical",
      speed: 8 + (2 + 2 * self.level) * self.level,
      stealth: 5 + 1 * self.level,
      gold_recruit_cost: 15 * self.level,
      food_recruit_cost: 40 * self.level,
      energy_recruit_cost: 2 * self.level,
      gold_train_cost: 10 * self.level,
      food_train_cost: 20 * self.level,
      energy_train_cost: 2 + 2 * self.level,
      image_url: self.role + "-#{[self.level, 3].min}.png"
    }
    when "dragon"
    {
      hp: 400 + (50 + 50 * self.level) * self.level,
      armor_type: "heavy",
      attack: 50 + (10 + 5 * self.level) * self.level,
      attack_type: "physical",
      speed: 10 + (4 + 3 * self.level) * self.level,
      stealth: 5 + 1 * self.level,
      gold_recruit_cost: 150 * self.level,
      food_recruit_cost: 130 * self.level,
      energy_recruit_cost: 10 * self.level,
      gold_train_cost: 20 * self.level,
      food_train_cost: 10 * self.level,
      energy_train_cost: 1 + 1 * self.level,
      image_url: self.role + "-#{[self.level, 2].min}.png"
    }
    end

    self.assign_attributes(unit_stats)
  end

  def can_recruit?
    role = self.role
    level = self.level
    town = self.town
    case role
    when "archer"
      town.researches.find_by(name: "Barracks").level >= level - 1
    when "mage"
      town.researches.find_by(name: "Magic Institut").level >= level - 1
    when "soldier"
      town.researches.find_by(name: "Barracks").level >= level - 1 &&
      town.researches.find_by(name: "Forge").level >= level - 1
    when "horseman"
      town.researches.find_by(name: "Barracks").level >= level &&
      town.researches.find_by(name: "Forge").level >= level
    when "wizard"
      town.researches.find_by(name: "Magic Institut").level * 0.5 >= level
    when "knight"
      town.researches.find_by(name: "Forge").level * 0.5 >= level &&
      town.researches.find_by(name: "Barracks").level * 0.5 >= level
    when "spearman"
      town.researches.find_by(name: "Barracks").level >= level &&
      town.researches.find_by(name: "Forge").level >= level
    when "heavyknight"
      town.researches.find_by(name: "Forge").level * 0.34 >= level &&
      town.researches.find_by(name: "Barracks").level * 0.5 >= level
    when "magicknight"
      town.researches.find_by(name: "Magic Institut").level * 0.5 >= level &&
      town.researches.find_by(name: "Barracks").level * 0.5 >= level &&
      town.researches.find_by(name: "Forge").level * 0.5 >= level
    when "orc"
      town.researches.find_by(name: "Monster Stable").level >= level
    when "dragon"
      town.researches.find_by(name: "Monster Stable").level * 0.2 >= level
    end
  end
end
