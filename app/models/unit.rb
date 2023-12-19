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
      hp: 90 + 10 * self.level,
      armor_type: "light",
      attack: 10 + 2 * self.level,
      attack_type: "physical",
      speed: 8 + 2 * self.level,
      stealth: 8 + 2 * self.level,
      gold_recruit_cost: 6 * self.level,
      food_recruit_cost: 6 * self.level,
      energy_recruit_cost: 1 * self.level,
      gold_train_cost: 5 * self.level,
      food_train_cost: 5 * self.level,
      energy_train_cost: 1 * self.level,
    }
    when "mage"
    {
      hp: 70 + 10 * self.level,
      armor_type: "light",
      attack: 10 + 2 * self.level,
      attack_type: "magical",
      speed: 5 + 1 * self.level,
      stealth: 5 + 1 * self.level,
      gold_recruit_cost: 5 * self.level,
      food_recruit_cost: 5 * self.level,
      energy_recruit_cost: 1 * self.level,
      gold_train_cost: 5 * self.level,
      food_train_cost: 5 * self.level,
      energy_train_cost: 1 * self.level,
    }
    when "soldier"
    {
      hp: 100 + 10 * self.level,
      armor_type: "medium",
      attack: 10 + 2 * self.level,
      attack_type: "physical",
      speed: 5 + 1 * self.level,
      stealth: 5 + 1 * self.level,
      gold_recruit_cost: 5 * self.level,
      food_recruit_cost: 5 * self.level,
      energy_recruit_cost: 1 * self.level,
      gold_train_cost: 5 * self.level,
      food_train_cost: 5 * self.level,
      energy_train_cost: 1 * self.level,
    }
    when "horseman"
    {
      hp: 80 + 10 * self.level,
      armor_type: "medium",
      attack: 10 + 2 * self.level,
      attack_type: "physical",
      speed: 10 + 2 * self.level,
      stealth: 10 + 2 * self.level,
      gold_recruit_cost: 12 * self.level,
      food_recruit_cost: 15 * self.level,
      energy_recruit_cost: 1 * self.level,
      gold_train_cost: 5 * self.level,
      food_train_cost: 5 * self.level,
      energy_train_cost: 1 * self.level,
    }
    when "wizard"
    {
      hp: 60 + 10 * self.level,
      armor_type: "light",
      attack: 10 + 2 * self.level,
      attack_type: "magical",
      speed: 5 + 1 * self.level,
      stealth: 5 + 1 * self.level,
      gold_recruit_cost: 15 * self.level,
      food_recruit_cost: 8 * self.level,
      energy_recruit_cost: 1 * self.level,
      gold_train_cost: 5 * self.level,
      food_train_cost: 5 * self.level,
      energy_train_cost: 1 * self.level,
    }
    end

    self.assign_attributes(unit_stats)
  end
end
