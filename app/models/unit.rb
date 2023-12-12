class Unit < ApplicationRecord
  belongs_to :homebase
  validates :name, :level, :hp, :armor_type, :attack, :attack_type, :speed, :stealth, :gold_recruit_cost, :food_recruit_cost, :energy_recruit_cost, :gold_train_cost, :food_train_cost, :energy_train_cost, :enrolled, presence: true
  validates :armor_type, inclusion: { in: %w(light medium heavy),
    message: "%{value} is not a valid armor type" }
  validates :attack_type, inclusion: { in: %w(physical magic),
    message: "%{value} is not a valid attack type" }
end
