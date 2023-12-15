class Battle < ApplicationRecord
  belongs_to :attacking_town, class_name: 'Town'
  belongs_to :defending_town, class_name: 'Town'

  def energy_cost
    if super.blank?
      set_energy_cost
    else
      super
    end
  end

  def result
    if super.blank?
      set_result
    else
      super
    end
  end

  private

  def set_energy_cost
    update(energy_cost: 20)
    return 20
  end

  def set_result
    update(result: "pending")
    return "pending"
  end
end
