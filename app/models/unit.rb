class Unit < ApplicationRecord
  attr_accessor :qty
  belongs_to :town
  validates :name, :level, :hp, :armor_type, :attack, :attack_type, :speed, :stealth, :gold_recruit_cost, :food_recruit_cost, :energy_recruit_cost, :gold_train_cost, :food_train_cost, :energy_train_cost, presence: true

  validates :armor_type, inclusion: { in: %w(light medium heavy),
    message: "%{value} is not a valid armor type" }
  validates :attack_type, inclusion: { in: %w(physical magical),
    message: "%{value} is not a valid attack type" }

  after_create :set_role

  def set_role
    self.role = self.class.name.downcase
    self.save
  end

  def self.roles
    self.distinct.pluck(:role)
  end

  self.roles.each do |role|
    define_singleton_method(role.pluralize.to_sym) do
      self.where(role: role)
    end
  end
end
