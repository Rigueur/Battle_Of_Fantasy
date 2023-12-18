class Town < ApplicationRecord

  belongs_to :user
  has_many :battles_as_attacking_town, class_name: 'Battle',
  foreign_key: :attacking_town_id
  has_many :battles_as_defending_town, class_name: 'Battle',
  foreign_key: :defending_town_id
  has_many :defense_builts
  has_many :defenses, through: :defense_builts
  has_many :structure_builts
  has_many :structures, through: :structure_builts
  has_many :research_levels
  has_many :researches, through: :research_levels
  has_many :units
  has_many :archers
  has_many :soldiers
  has_many :wizards
  has_many :mages
  has_many :horsemen
  validates :name, :coordinates, :wood_quantity, :stone_quantity, :gold_quantity, :food_quantity, presence: true
  validates :research_ongoing, :construction_ongoing, :defense_ongoing, inclusion: [true, false]

  after_create :set_resources_updated_at

  def set_resources_updated_at
    self.update(resources_updated_at: 0.minutes.from_now)
  end

  def update_resources
    if self.resources_updated_at < Time.now
      minutes_since_last_update = ((Time.now - self.resources_updated_at) / 60).round
      self.update(
        wood_quantity: self.wood_quantity + (self.structures.pluck(:wood_production).compact.sum * minutes_since_last_update),
        stone_quantity: self.stone_quantity + (self.structures.pluck(:stone_production).compact.sum * minutes_since_last_update),
        gold_quantity: self.gold_quantity + (self.structures.pluck(:gold_production).compact.sum * minutes_since_last_update),
        food_quantity: self.food_quantity + (self.structures.pluck(:food_production).compact.sum * minutes_since_last_update),
        resources_updated_at: 0.minutes.from_now
      )
    end
  end
end
