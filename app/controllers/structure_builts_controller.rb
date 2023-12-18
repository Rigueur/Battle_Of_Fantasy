class StructureBuiltsController < ApplicationController
  def index
    @town = Town.find(params[:town_id])
    @structure_builts = StructureBuilt.all.where(town_id: params[:town_id])
  end

  def update
    @structure_built = StructureBuilt.find(params[:id])
    @town = Town.find(params[:town_id])
    unless @town.construction_ongoing || @town.wood_quantity < @structure_built.structure.wood_cost || @town.stone_quantity < @structure_built.structure.stone_cost || @town.gold_quantity < @structure_built.structure.gold_cost
      @town.update(construction_ongoing: true, construction_end_time: @structure_built.structure.upgrade_time.to_i.minutes.from_now)
      @town.update(wood_quantity: @town.wood_quantity - @structure_built.structure.wood_cost, stone_quantity: @town.stone_quantity - @structure_built.structure.stone_cost, gold_quantity: @town.gold_quantity - @structure_built.structure.gold_cost)
      @structure_built.update(updated_at: Time.now)
      flash[:notice] = "Construction began"
      redirect_to town_path(@town)
    else
      if @town.wood_quantity < @structure_built.structure.wood_cost || @town.stone_quantity < @structure_built.structure.stone_cost || @town.gold_quantity < @structure_built.structure.gold_cost
        flash[:notice] = "Not enough resources"
        redirect_to request.referrer
      else
        flash[:notice] = "Construction already in progress"
        redirect_to request.referrer
      end
    end
  end
end
