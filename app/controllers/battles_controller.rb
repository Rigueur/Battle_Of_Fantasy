class BattlesController < ApplicationController
  def new
    @battle = Battle.new
    @town = Town.find(params[:town_id])
  end

  def create
    @battle = Battle.new(battle_params)
    @town = Town.find(params[:town_id])
    @battle.attacking_town = @town

    attacking_units = Battle.select_units_for_battle(params[:units], @town)

    @battle.calculate_and_set_energy_cost(attacking_units)

    # check if attacking_town.user.energy is enough
    if @battle.attacking_town.user.energy < @battle.energy_cost
      flash[:alert] = "You don't have enough energy to attack"
      redirect_to request.referrer
      # check if defending_town is under protection
    elsif @battle.defending_town.last_attacked_at && Time.current - @battle.defending_town.last_attacked_at < 5.hours
      flash[:alert] = "This town cannot be attacked."
      redirect_to request.referrer
    else
      # Update defending_town's resources before calculating the result
      @battle.defending_town.update_resources
      message = @battle.calculate_and_set_result(attacking_units, @battle.defending_town_id, current_user)
      current_user.reload
      @battle.image_url = "battle-scene-#{rand(1..5)}.png"
      if @battle.save
        # Update attacking_town.user.energy
        @battle.attacking_town.user.update(energy: current_user.energy - @battle.energy_cost)

        # Update attacking_town.units
        eval(@battle.attacking_units_lost).each do |(role, level), quantity|
          @battle.attacking_town.units.where(role: role, level: level).limit(quantity).destroy_all
        end

        # Update defending_town.units
        eval(@battle.defending_units_lost).each do |(role, level), quantity|
          @battle.defending_town.units.where(role: role, level: level).limit(quantity).destroy_all
        end

        resources_won = JSON.parse(@battle.resources_won)

        # Update attacking_town resources
        @battle.attacking_town.update(
          wood_quantity: @battle.attacking_town.wood_quantity + resources_won["wood"],
          stone_quantity: @battle.attacking_town.stone_quantity + resources_won["stone"],
          gold_quantity: @battle.attacking_town.gold_quantity + resources_won["gold"],
          food_quantity: @battle.attacking_town.food_quantity + resources_won["food"]
        )

        # Update defending_town resources
        @battle.defending_town.update(
          wood_quantity: @battle.defending_town.wood_quantity - resources_won["wood"],
          stone_quantity: @battle.defending_town.stone_quantity - resources_won["stone"],
          gold_quantity: @battle.defending_town.gold_quantity - resources_won["gold"],
          food_quantity: @battle.defending_town.food_quantity - resources_won["food"]
        )

        # Update defending_town.last_attacked_at
        @battle.defending_town.update(last_attacked_at: Time.current)

        flash[:notice] = message

        redirect_to battle_path(@battle)
      else
        render :new
      end
    end
  end

  def show
    @battle = Battle.find(params[:id])
    @town = @battle.attacking_town
  end

  def calculate_energy_cost
    town = Town.find(params[:attacking_town_id])
    result = Battle.select_units_for_battle(params[:units], town)
    attacking_units = result
    battle = Battle.new(attacking_town: town, defending_town: Town.find(params[:defending_town_id]))
    energy_cost = battle.calculate_and_set_energy_cost(attacking_units)
    render json: { energy_cost: energy_cost }
  end

  private

  def battle_params
    params.require(:battle).permit(:defending_town_id, :attacking_town_id)
  end
end
