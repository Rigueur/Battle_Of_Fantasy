class Battle < ApplicationRecord
  belongs_to :attacking_base, class_name: 'Homebase'
  belongs_to :defending_base, class_name: 'Homebase'
end
