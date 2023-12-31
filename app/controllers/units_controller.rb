class UnitsController < ApplicationController
  def index
    # We are defining the @archers, @mages, @soldiers... variables
    Unit.roles.each do |role|
      instance_variable_set "@#{role.pluralize}", Unit.where(town_id: params[:town_id], role: role)
    end
    @town = Town.find(params[:town_id])
    @unit = Unit.new
  end

  def create
    @role = params[:unit][:role]
    @quantity = params[:unit][:qty].to_i
    @quantity = 1 if @quantity <= 0
    town = Town.find(params[:town_id])
    unit = @role.capitalize.constantize.new(level: 1, town_id: town.id)
    unit.set_role
    unit.set_stats

    # Check if the town has the required researches to recruit the unit
    unless unit.can_recruit?
      flash[:alert] = "You dont have the required researches"
    else
      # Check if the town has enough resources to recruit the unit
      if town.gold_quantity >= (unit.gold_recruit_cost * @quantity) && town.food_quantity >= (unit.food_recruit_cost * @quantity) && current_user.energy >= (unit.energy_recruit_cost * @quantity)
        @quantity.times do
          unit = @role.capitalize.constantize.new(level: 1, town_id: town.id)
          unit.save!
        end
        town.gold_quantity -= @quantity * unit.gold_recruit_cost
        town.food_quantity -= @quantity * unit.food_recruit_cost
        current_user.energy -= @quantity * unit.energy_recruit_cost
        flash[:notice] = "Unit created" if unit.save && town.save && current_user.save
      else
        flash[:alert] = "Not enough resources to recruit this unit"
      end
    end

    # refresh the page
    redirect_to request.referrer
  end

  def cost
    role = params[:role]
    level = params[:level].to_i
    unit = role.capitalize.constantize.new(level: level)
    unit.set_role
    unit.set_stats
    render json: { foodCost: unit.food_recruit_cost, goldCost: unit.gold_recruit_cost, energyCost: unit.energy_recruit_cost }
  end

  def role_index
    @town = Town.find(params[:town_id])
    @role = params[:role]
    @units = @town.units.where(role: @role)
  end

  def upgrade
    # Get the role and level from the params
    role = params[:role]
    level = params[:level].to_i

    # Get the quantity to be upgraded
    quantity = params[:quantity].to_i

    # Get the town
    town = Town.find(params[:town_id])

    # Get the units to be upgraded
    units = Unit.where(town_id: town.id, role: role, level: level).limit(quantity)

    # Calculate the new level
    new_level = level + 1

    # Create a new unit with the new level to get the cost
    unit = role.capitalize.constantize.new(level: new_level, town_id: town.id)
    unit.set_role
    unit.set_stats

    # Check if the town has the required researches to upgrade the units
    unless unit.can_recruit?
      flash[:alert] = "You dont have the required researches"
    else

      # Check if the town has enough resources to upgrade the units
      total_gold_cost = unit.gold_train_cost * quantity
      total_food_cost = unit.food_train_cost * quantity
      total_energy_cost = unit.energy_train_cost.to_i * quantity

      if town.gold_quantity >= total_gold_cost && town.food_quantity >= total_food_cost && current_user.energy >= total_energy_cost
        # Deduct the upgrade cost from the town's resources
        town.gold_quantity -= total_gold_cost
        town.food_quantity -= total_food_cost
        current_user.energy -= total_energy_cost

        # Update the units' stats
        units.each do |unit|
          unit.level = new_level
          unit.set_stats
          unit.save!
        end

        # Save the town and the units
        if town.save && units.all?(&:save) && current_user.save
          flash[:notice] = "Units upgraded"
        else
          flash[:alert] = "Failed to upgrade units"
        end
      else
        flash[:alert] = "Not enough resources to upgrade these units"
      end
    end

    # Redirect to the previous page
    redirect_to request.referrer
  end

  def upgrade_cost
    role = params[:role]
    level = params[:level].to_i
    quantity = params[:quantity].to_i

    result = calculate_upgrade_cost(role, level, quantity)

    render json: result
  end

  private

  def calculate_upgrade_cost(role, level, quantity)
    # Create a new unit with the level to get the cost
    unit = role.capitalize.constantize.new(level: level)
    unit.set_role
    unit.set_stats

    # Calculate the total cost
    total_gold_cost = unit.gold_train_cost * quantity
    total_food_cost = unit.food_train_cost * quantity
    total_energy_cost = unit.energy_train_cost.to_i * quantity

    # Calculate the new level
    new_level = level + 1

    # Calculate the new stats
    new_unit = role.capitalize.constantize.new(level: new_level)
    new_unit.set_role
    new_unit.set_stats

    unit.image_url = view_context.asset_path(unit.image_url)

    # Return the total cost and the stats
    { cost: { gold: total_gold_cost, food: total_food_cost, energy: total_energy_cost }, stats: unit.attributes, new_stats: new_unit.attributes }
  end

  # We are defining the archer, mage, soldier... methods wich works as an index of a specific role (archer, mage, soldier...)
  # and it gives the @archers, @mages, @soldiers... variables corresponding to the role
  Unit.roles.each do |role|
    define_singleton_method(role.to_sym) do
      instance_variable_set "@#{role.pluralize}", Unit.where(town_id: params[:town_id], role: role)
    end
  end
end
