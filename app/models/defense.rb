class Defense < ApplicationRecord
  has_many :defense_builts
  validates :name, :image_url, :level, :wood_cost, :stone_cost, :gold_cost, :upgrade_time, :defense_value, presence: true
end
