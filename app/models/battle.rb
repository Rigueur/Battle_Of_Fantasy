class Battle < ApplicationRecord
  belongs_to :attacking_town, class_name: 'Town'
  belongs_to :defending_town, class_name: 'Town'
  validates :energy_cost, :result, presence: true
end
