class Battle < ApplicationRecord
  belongs_to :attacking_town, class_name: 'Town'
  belongs_to :defending_town, class_name: 'Town'

  def calculate_and_set_energy_cost(attacking_unit_ids)
    set_energy_cost(attacking_unit_ids)
  end

  def calculate_and_set_result(attacking_unit_ids, defending_town_id, user)
    set_result(attacking_unit_ids, defending_town_id, user)
  end

  def self.select_units_for_battle(units_params, town)
    attacking_units = []
    units_params.each do |role, levels|
      levels.each do |level, quantity|
        quantity = quantity.to_i
        units = town.units.where(role: role, level: level.to_i).limit(quantity)
        if units.count == quantity
          attacking_units.concat(units.pluck(:id))
        else
          return { error: "You don't have enough #{role.pluralize} of level #{level} to attack" }
        end
      end
    end
    attacking_units
  end

  private

  def set_energy_cost(attacking_unit_ids)
    attacking_units = Unit.where(id: attacking_unit_ids)
    total_units = attacking_units.count
    total_speed = attacking_units.sum(:speed)

    energy_cost = total_units - (total_speed / 20.0)
    energy_cost = [energy_cost, 0].max  # Ensure the energy cost is not negative
    energy_cost = energy_cost.round  # Round the energy cost to the nearest integer

    update(energy_cost: energy_cost)
    energy_cost
  end

  def set_result(attacking_unit_ids, defending_town_id, user)
    attacking_units = Unit.where(id: attacking_unit_ids)
    attacking_units_attack = attacking_units.sum(:attack)
    attacking_units_hp = attacking_units.sum(:hp)

    defending_town = Town.find(defending_town_id)
    defending_units = defending_town.units
    defending_units_attack = defending_units.sum(:attack)
    defending_units_hp = defending_units.sum(:hp)

    attacking_units_lost = Hash.new(0)
    defending_units_lost = Hash.new(0)

    result = ""
    resources_won_percentage = 0
    message = ""
    while attacking_units_hp >= 0 && defending_units_hp >= 0
      # Each army attacks the other
      defending_units_hp -= attacking_units_attack
      attacking_units_hp -= defending_units_attack

      # Check if either army has lost more than 70% of their units
      if attacking_units_hp <= 0.3 * attacking_units.sum(:hp) && defending_units_hp <= 0.3 * defending_units.sum(:hp)
        result = 'Tactical retreat'
        resources_won_percentage = 0.2
        message = user.xp_gain(30)
        break
      end

      # Check if either army has been defeated
      if attacking_units_hp <= 0
        result = 'Defending town won'
        resources_won_percentage = 0
        message = user.xp_gain(10)
      elsif defending_units_hp <= 0
        result = 'Attacking army won'
        resources_won_percentage = 0.5
        message = user.xp_gain(50)
      end
    end

    # Calculate the percentage of HP lost by each army
    attacking_units_hp_lost_percentage = 1 - (attacking_units_hp.to_f / attacking_units.sum(:hp))
    defending_units_hp_lost_percentage = 1 - (defending_units_hp.to_f / defending_units.sum(:hp))

    # Calculate the number of units lost by each army
    attacking_units_lost = attacking_units.sort_by { |unit| [unit.level, unit.hp, unit.attack] }.group_by { |unit| [unit.role, unit.level] }.transform_values do |units|
      (units.size * attacking_units_hp_lost_percentage).round
    end

    defending_units_lost = defending_units.sort_by { |unit| [unit.level, unit.hp, unit.attack] }.group_by { |unit| [unit.role, unit.level] }.transform_values do |units|
      (units.size * defending_units_hp_lost_percentage).round
    end

    # Calculate the resources won by the attacker
    resources_won = {
      wood: (defending_town.wood_quantity * resources_won_percentage).round,
      stone: (defending_town.stone_quantity * resources_won_percentage).round,
      food: (defending_town.food_quantity * resources_won_percentage).round,
      gold: (defending_town.gold_quantity * resources_won_percentage).round
    }

    update(result: result, attacking_units_lost: attacking_units_lost.to_json, defending_units_lost: defending_units_lost.to_json, resources_won: resources_won.to_json)
    message
  end
end
