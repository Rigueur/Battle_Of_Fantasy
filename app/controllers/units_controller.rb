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
    case @role
    when "archer"
      if @quantity > 1
        @quantity.times do
          created = Archer.create(name: "archer", level: 1, hp: 100, armor_type: "light", attack: 10, attack_type: "physical", speed: 5, stealth: 5, gold_recruit_cost: 5, food_recruit_cost: 5, energy_recruit_cost: 5, gold_train_cost: 5, food_train_cost: 5, energy_train_cost: 5, enrolled: false, town_id: params[:town_id])
        end
      else
        Archer.create(name: "archer", level: 1, hp: 100, armor_type: "light", attack: 10, attack_type: "physical", speed: 5, stealth: 5, gold_recruit_cost: 5, food_recruit_cost: 5, energy_recruit_cost: 5, gold_train_cost: 5, food_train_cost: 5, energy_train_cost: 5, enrolled: false, town_id: params[:town_id])
      end

    when "mage"
      if @quantity > 1
        @quantity.times do
          created = Mage.create(name: "mage", level: 1, hp: 100, armor_type: "light", attack: 10, attack_type: "magic", speed: 5, stealth: 5, gold_recruit_cost: 5, food_recruit_cost: 5, energy_recruit_cost: 5, gold_train_cost: 5, food_train_cost: 5, energy_train_cost: 5, enrolled: false, town_id: params[:town_id])
        end
      else
        Mage.create(name: "mage", level: 1, hp: 100, armor_type: "light", attack: 10, attack_type: "magic", speed: 5, stealth: 5, gold_recruit_cost: 5, food_recruit_cost: 5, energy_recruit_cost: 5, gold_train_cost: 5, food_train_cost: 5, energy_train_cost: 5, enrolled: false, town_id: params[:town_id])
      end

    when "soldier"
      if @quantity > 1
        @quantity.times do
          created = Soldier.new(name: "soldier", level: 1, hp: 100, armor_type: "medium", attack: 10, attack_type: "physical", speed: 5, stealth: 5, gold_recruit_cost: 5, food_recruit_cost: 5, energy_recruit_cost: 5, gold_train_cost: 5, food_train_cost: 5, energy_train_cost: 5, enrolled: false, town_id: params[:town_id])
        end
      else
        Soldier.new(name: "soldier", level: 1, hp: 100, armor_type: "medium", attack: 10, attack_type: "physical", speed: 5, stealth: 5, gold_recruit_cost: 5, food_recruit_cost: 5, energy_recruit_cost: 5, gold_train_cost: 5, food_train_cost: 5, energy_train_cost: 5, enrolled: false, town_id: params[:town_id])
      end

    when "horseman"
      if @quantity > 1
        @quantity.times do
          created = Horseman.new(name: "horseman", level: 1, hp: 100, armor_type: "medium", attack: 10, attack_type: "physical", speed: 10, stealth: 5, gold_recruit_cost: 5, food_recruit_cost: 5, energy_recruit_cost: 5, gold_train_cost: 5, food_train_cost: 5, energy_train_cost: 5, enrolled: false, town_id: params[:town_id])
        end
      else
        Horseman.new(name: "horseman", level: 1, hp: 100, armor_type: "medium", attack: 10, attack_type: "physical", speed: 10, stealth: 5, gold_recruit_cost: 5, food_recruit_cost: 5, energy_recruit_cost: 5, gold_train_cost: 5, food_train_cost: 5, energy_train_cost: 5, enrolled: false, town_id: params[:town_id])
      end
    end

    if created
      flash[:notice] = "Unit created"
    end

    redirect_to town_path(params[:town_id])
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
