class StructureBuiltsController < ApplicationController
  def index
    @town = Town.find(params[:towns_id])
    @structure_builts = StructureBuilt.all.where(town_id: params[:towns_id])
  end

  def update
    @structure_built = StructureBuilt.find(params[:id])
    @structure_built.update(structure_built_params)
    redirect_to towns_structures_path
  end

  private

  def structure_built_params
    params.require(:structure_built).permit(:structure_id)
  end
end
