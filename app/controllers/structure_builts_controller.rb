class StructureBuiltsController < ApplicationController
  def index
    @homebase = Homebase.find(params[:homebases_id])
    @structure_builts = StructureBuilt.all.where(homebase_id: params[:homebases_id])
  end

  def update
    @structure_built = StructureBuilt.find(params[:id])
    @structure_built.update(structure_built_params)
    redirect_to homebases_structures_path
  end

  private

  def structure_built_params
    params.require(:structure_built).permit(:structure_id)
  end
end
