class Homebase < ApplicationRecord
  belongs_to :user
  has_many :attacking_battles, class_name: 'Battle',
  foreign_key: 'attacking_base_id'
  has_many :defending_battles, class_name: 'Battle',
  foreign_key: 'defending_base_id'
  has_many :defense_builts
  has_many :structure_builts
  has_many :research_levels
  has_many :archers
  has_many :soldiers
  has_many :wizards
  has_many :mages
  has_many :horsemen
end
