class DefenseBuiltsController < ApplicationController
  def index
    @homebase = Homebase.find(params[:homebases_id])
    @defense_builts = DefenseBuilt.all.where(homebase_id: params[:homebases_id])
  end

  def update
    @defense_built = DefenseBuilt.find(params[:id])
    @defense_built.update(defense_built_params)
    redirect_to homebasis_defenses_path
  end

  private

  def defense_built_params
    params.require(:defense_built).permit(:defense_id)
  end
end
