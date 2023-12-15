class UnitsController < ApplicationController
  def index
    # We are defining the @archers, @mages, @soldiers... variables
    Unit.roles.each do |role|
      instance_variable_set "@#{role.pluralize}", Unit.send("#{role.pluralize}").where(town_id: params[:town_id])
    end
    @town = Town.find(params[:town_id])
    @unit = Unit.new
  end

  def create
    @role = params[:unit][:role]
    @quantity = params[:unit][:qty].to_i
    @quantity = 1 if @quantity <= 0
    town = Town.find(params[:town_id])
    unit = Unit.new(unit_stats(@role, 1))

    if town.gold_quantity >= (unit.gold_recruit_cost * @quantity) && town.food_quantity >= (unit.food_recruit_cost * @quantity) && current_user.energy >= (unit.energy_recruit_cost * @quantity)
      @quantity.times do
        unit = @role.capitalize.constantize.new(unit_stats(@role, 1))
        unit.town_id = town.id
        unit.save!
      end
      town.gold_quantity -= @quantity * unit.gold_recruit_cost
      town.food_quantity -= @quantity * unit.food_recruit_cost
      current_user.energy -= @quantity * unit.energy_recruit_cost
      flash[:notice] = "Unit created" if unit.save && town.save && current_user.save
    else
      flash[:alert] = "Not enough resources to recruit this unit"
    end

    # refresh the page
    redirect_to request.referrer
end

  private

  def unit_stats(role, level)
    case role
    when "archer"
    unit_stats = {
      name: "archer",
      level: level,
      hp: 90 + 10 * level,
      armor_type: "light",
      attack: 10 + 2 * level,
      attack_type: "physical",
      speed: 8 + 2 * level,
      stealth: 8 + 2 * level,
      gold_recruit_cost: 5 * level,
      food_recruit_cost: 5 * level,
      energy_recruit_cost: 1 * level,
      gold_train_cost: 5 * level,
      food_train_cost: 5 * level,
      energy_train_cost: 1 * level,
    }
    when "mage"
    unit_stats = {
      name: "mage",
      level: level,
      hp: 70 + 10 * level,
      armor_type: "light",
      attack: 10 + 2 * level,
      attack_type: "magical",
      speed: 5 + 1 * level,
      stealth: 5 + 1 * level,
      gold_recruit_cost: 5 * level,
      food_recruit_cost: 5 * level,
      energy_recruit_cost: 1 * level,
      gold_train_cost: 5 * level,
      food_train_cost: 5 * level,
      energy_train_cost: 1 * level,
    }
    when "soldier"
    unit_stats = {
      name: "soldier",
      level: level,
      hp: 100 + 10 * level,
      armor_type: "medium",
      attack: 10 + 2 * level,
      attack_type: "physical",
      speed: 5 + 1 * level,
      stealth: 5 + 1 * level,
      gold_recruit_cost: 5 * level,
      food_recruit_cost: 5 * level,
      energy_recruit_cost: 1 * level,
      gold_train_cost: 5 * level,
      food_train_cost: 5 * level,
      energy_train_cost: 1 * level,
    }
    when "horseman"
    unit_stats = {
      name: "horseman",
      level: level,
      hp: 80 + 10 * level,
      armor_type: "medium",
      attack: 10 + 2 * level,
      attack_type: "physical",
      speed: 10 + 2 * level,
      stealth: 10 + 2 * level,
      gold_recruit_cost: 5 * level,
      food_recruit_cost: 5 * level,
      energy_recruit_cost: 1 * level,
      gold_train_cost: 5 * level,
      food_train_cost: 5 * level,
      energy_train_cost: 1 * level,
    }
  when "wizard"
    unit_stats = {
      name: "wizard",
      level: level,
      hp: 60 + 10 * level,
      armor_type: "light",
      attack: 10 + 2 * level,
      attack_type: "magical",
      speed: 5 + 1 * level,
      stealth: 5 + 1 * level,
      gold_recruit_cost: 5 * level,
      food_recruit_cost: 5 * level,
      energy_recruit_cost: 1 * level,
      gold_train_cost: 5 * level,
      food_train_cost: 5 * level,
      energy_train_cost: 1 * level,
    }
    end
  end

  # We are defining the archer, mage, soldier... methods wich works as an index of a specific role (archer, mage, soldier...)
  # and it gives the @archers, @mages, @soldiers... variables corresponding to the role
  Unit.roles.each do |role|
    define_singleton_method(role.to_sym) do
      instance_variable_set "@#{role.pluralize}", Unit.send("#{role.pluralize}").where(town_id: params[:town_id])
    end
  end
end
