class Structure < ApplicationRecord
  has_many :structure_builts
  validates :name, :image_url, :level, :wood_cost, :stone_cost, :gold_cost, :upgrade_time, :wood_production, :stone_production, :gold_production, :food_production, presence: true
end
