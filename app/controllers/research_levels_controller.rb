class ResearchLevelsController < ApplicationController
  def index
    @town = Town.find(params[:towns_id])
    @research_levels = ResearchLevel.all.where(town_id: params[:towns_id])
  end

  def update
    @research_level = ResearchLevel.find(params[:id])
    @research_level.update(research_level_params)
    redirect_to towns_researches_path
  end

  private

  def research_level_params
    params.require(:research_level).permit(:research_id)
  end
end
