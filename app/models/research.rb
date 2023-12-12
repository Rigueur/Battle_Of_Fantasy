class Research < ApplicationRecord
  has_many :research_levels
  validates :name, :image_url, :level, :wood_cost, :stone_cost, :gold_cost, :upgrade_time, presence: true
end
