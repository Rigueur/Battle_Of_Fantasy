class ResearchLevelsController < ApplicationController
  def index
    @homebase = Homebase.find(params[:homebases_id])
    @research_levels = ResearchLevel.all.where(homebase_id: params[:homebases_id])
  end

  def update
    @research_level = ResearchLevel.find(params[:id])
    @research_level.update(research_level_params)
    redirect_to homebases_researches_path
  end

  private

  def research_level_params
    params.require(:research_level).permit(:research_id)
  end
end
