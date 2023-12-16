class ResearchLevelsController < ApplicationController
  def index
    @town = Town.find(params[:town_id])
    @research_levels = ResearchLevel.all.where(town_id: params[:town_id])
  end

  def update
    @research_level = ResearchLevel.find(params[:id])
    @town = Town.find(params[:town_id])
    unless @town.research_ongoing || @town.wood_quantity < @research_level.research.wood_cost || @town.stone_quantity < @research_level.research.stone_cost || @town.gold_quantity < @research_level.research.gold_cost
      @town.update(research_ongoing: true, research_end_time: @research_level.research.upgrade_time.to_i.minutes.from_now)
      @town.update(wood_quantity: @town.wood_quantity - @research_level.research.wood_cost, stone_quantity: @town.stone_quantity - @research_level.research.stone_cost, gold_quantity: @town.gold_quantity - @research_level.research.gold_cost)
      @research_level.update(updated_at: Time.now)
      flash[:notice] = "Research began"
      redirect_to town_path(@town)
    else
      if @town.wood_quantity < @research_level.research.wood_cost || @town.stone_quantity < @research_level.research.stone_cost || @town.gold_quantity < @research_level.research.gold_cost
        flash[:notice] = "Not enough resources"
        redirect_to request.referrer
      else
        flash[:notice] = "Research already in progress"
        redirect_to request.referrer
      end
    end
  end
end
