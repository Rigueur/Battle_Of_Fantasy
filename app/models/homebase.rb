class Homebase < ApplicationRecord
  belongs_to :user
  has_many :battles_as_attacking_base, class_name: 'Battle',
  foreign_key: :attacking_base_id
  has_many :battles_as_defending_base, class_name: 'Battle',
  foreign_key: :defending_base_id
  has_many :defense_builts
  has_many :structure_builts
  has_many :research_levels
  has_many :archers
  has_many :soldiers
  has_many :wizards
  has_many :mages
  has_many :horsemen
  validates :name, :coordinates, :wood_quantity, :stone_quantity, :gold_quantity, :food_quantity, :research_ongoing, :construction_ongoing, :defense_ongoing, presence: true
end
