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
    created = false
    @role = params[:unit][:role]
    @quantity = params[:unit][:qty].to_i
    @quantity = 1 if @quantity <= 0
    town = Town.find(params[:town_id])
    unit = Unit.new(gold_recruit_cost: 5, food_recruit_cost: 5, energy_recruit_cost: 5)

    case @role
    when "archer"
      if town.gold_quantity >= unit.gold_recruit_cost && town.food_quantity >= unit.food_recruit_cost && current_user.energy >= unit.energy_recruit_cost
        @quantity.times do
          unit = Archer.create(name: "archer", level: 1, hp: 100, armor_type: "light", attack: 10, attack_type: "physical", speed: 5, stealth: 5, gold_recruit_cost: 5, food_recruit_cost: 5, energy_recruit_cost: 5, gold_train_cost: 5, food_train_cost: 5, energy_train_cost: 5, enrolled: false, town_id: params[:town_id])
          town.gold_quantity -= unit.gold_recruit_cost
          town.food_quantity -= unit.food_recruit_cost
          current_user.energy -= unit.energy_recruit_cost
        end
        flash[:notice] = "Unit created" if unit.save && town.save && current_user.save
      else
        flash[:alert] = "Not enough resources to recruit this unit"
      end

    when "mage"
      if town.gold_quantity >= unit.gold_recruit_cost && town.food_quantity >= unit.food_recruit_cost && current_user.energy >= unit.energy_recruit_cost
        @quantity.times do
          unit = Mage.create(name: "mages", level: 1, hp: 100, armor_type: "light", attack: 10, attack_type: "magic", speed: 5, stealth: 5, gold_recruit_cost: 5, food_recruit_cost: 5, energy_recruit_cost: 5, gold_train_cost: 5, food_train_cost: 5, energy_train_cost: 5, enrolled: false, town_id: params[:town_id])
          town.gold_quantity -= unit.gold_recruit_cost
          town.food_quantity -= unit.food_recruit_cost
          current_user.energy -= unit.energy_recruit_cost
        end
        flash[:notice] = "Unit created" if unit.save && town.save && current_user.save
      else
        flash[:alert] = "Not enough resources to recruit this unit"
      end

    when "soldier"
      if town.gold_quantity >= unit.gold_recruit_cost && town.food_quantity >= unit.food_recruit_cost && current_user.energy >= unit.energy_recruit_cost
        @quantity.times do
          unit = Soldier.new(name: "soldier", level: 1, hp: 100, armor_type: "medium", attack: 10, attack_type: "physical", speed: 5, stealth: 5, gold_recruit_cost: 5, food_recruit_cost: 5, energy_recruit_cost: 5, gold_train_cost: 5, food_train_cost: 5, energy_train_cost: 5, enrolled: false, town_id: params[:town_id])
          town.gold_quantity -= unit.gold_recruit_cost
          town.food_quantity -= unit.food_recruit_cost
          current_user.energy -= unit.energy_recruit_cost
        end
        flash[:notice] = "Unit created" if unit.save && town.save && current_user.save
      else
        flash[:alert] = "Not enough resources to recruit this unit"
      end

    when "horseman"
      if town.gold_quantity >= unit.gold_recruit_cost && town.food_quantity >= unit.food_recruit_cost && current_user.energy >= unit.energy_recruit_cost
        @quantity.times do
          unit = Horseman.new(name: "horseman", level: 1, hp: 100, armor_type: "medium", attack: 10, attack_type: "physical", speed: 10, stealth: 5, gold_recruit_cost: 5, food_recruit_cost: 5, energy_recruit_cost: 5, gold_train_cost: 5, food_train_cost: 5, energy_train_cost: 5, enrolled: false, town_id: params[:town_id])
          town.gold_quantity -= unit.gold_recruit_cost
          town.food_quantity -= unit.food_recruit_cost
          current_user.energy -= unit.energy_recruit_cost
        end
        flash[:notice] = "Unit created" if unit.save && town.save && current_user.save
      else
        flash[:alert] = "Not enough resources to recruit this unit"
      end
    end

    if created
      flash[:notice] = "Unit created"
    end

    # refresh the page
    redirect_to request.referrer

end

  private

  def unit_params
    params.require(:unit).permit(:name, :level)
  end

  # We are defining the archer, mage, soldier... methods wich works as an index of a specific role (archer, mage, soldier...)
  # and it gives the @archers, @mages, @soldiers... variables corresponding to the role
  Unit.roles.each do |role|
    define_singleton_method(role.to_sym) do
      instance_variable_set "@#{role.pluralize}", Unit.send("#{role.pluralize}").where(town_id: params[:town_id])
    end
  end
end
