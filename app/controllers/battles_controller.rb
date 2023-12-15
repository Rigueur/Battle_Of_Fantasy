class BattlesController < ApplicationController
  def new
    @battle = Battle.new
    @town = Town.find(params[:town_id])
  end

  def create
    @battle = Battle.new(battle_params)
    @town = Town.find(params[:town_id])
    @battle.attacking_town = @town
    if @battle.attacking_town.user.energy < @battle.energy_cost
      flash[:alert] = "You don't have enough energy to attack"
      render :new
    else
      if @battle.save
        @battle.attacking_town.user.update(energy: @battle.attacking_town.user.energy - @battle.energy_cost)
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

  private

  def battle_params
    params.require(:battle).permit(:defending_town_id)
  end
end
