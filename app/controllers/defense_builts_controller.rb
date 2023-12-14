class DefenseBuiltsController < ApplicationController
  def index
    @town = Town.find(params[:town_id])
    @defense_builts = DefenseBuilt.all.where(town_id: params[:town_id])
  end

  def update
    @defense_built = DefenseBuilt.find(params[:id])
    @town = Town.find(params[:town_id])
    unless @town.defense_ongoing || @town.wood_quantity < @defense_built.defense.wood_cost || @town.stone_quantity < @defense_built.defense.stone_cost || @town.gold_quantity < @defense_built.defense.gold_cost
      @town.update(defense_ongoing: true, defense_end_time: @defense_built.defense.upgrade_time.to_i.minutes.from_now)
      @town.update(wood_quantity: @town.wood_quantity - @defense_built.defense.wood_cost, stone_quantity: @town.stone_quantity - @defense_built.defense.stone_cost, gold_quantity: @town.gold_quantity - @defense_built.defense.gold_cost)
      @defense_built.update(updated_at: Time.now)
      redirect_to towns_defenses_path
    end
  end
end
