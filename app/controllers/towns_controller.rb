class TownsController < ApplicationController

  def show
    @town = Town.find_by(user_id: current_user.id)
  end

  def end_construction
    @town = Town.find(params[:id])
    if @town.construction_ongoing
      sleep(1)
      if @town.update(construction_ongoing: false)
        head :no_content
        upgrade_structure
      else
        render json: @town.errors, status: :unprocessable_entity
      end
    end
  end

  def end_research
    @town = Town.find(params[:id])
    if @town.research_ongoing
      sleep(1)
      if @town.update(research_ongoing: false)
        head :no_content
        upgrade_research
      else
        render json: @town.errors, status: :unprocessable_entity
      end
    end
  end

  def end_defense
    @town = Town.find(params[:id])
    if @town.defense_ongoing
      sleep(1)
      if @town.update(defense_ongoing: false)
        head :no_content
        upgrade_defense
      else
        render json: @town.errors, status: :unprocessable_entity
      end
    end
  end

  def update_resources
    @town = Town.find(params[:id])
    if @town.update(
        wood_quantity: @town.wood_quantity + params[:wood].to_i,
        stone_quantity: @town.stone_quantity + params[:stone].to_i,
        food_quantity: @town.food_quantity + params[:food].to_i,
        gold_quantity: @town.gold_quantity + params[:gold].to_i,
        resources_updated_at: 0.minutes.from_now
      )
      render partial: 'shared/footer', locals: { town: @town }
    else
      render json: @town.errors, status: :unprocessable_entity
    end
  end

  def update_energy
    @user = current_user
    if @user.update(
      energy: current_user.energy + params[:energy].to_i,
      energy_updated_at: 0.minutes.from_now
    )
      render partial: 'shared/footer', locals: { town: @town }
    else
      render json: current_user.errors, status: :unprocessable_entity
    end
  end

  private

  def upgrade_structure
    @structure_built = StructureBuilt.order(updated_at: :desc).first
    upgraded_structure = Structure.find_by(name: @structure_built.structure.name, level: @structure_built.structure.level + 1)
    @structure_built.update({ structure_id: upgraded_structure.id })
  end

  def upgrade_research
    @research_level = ResearchLevel.order(updated_at: :desc).first
    upgraded_research = Research.find_by(name: @research_level.research.name, level: @research_level.research.level + 1)
    @research_level.update({ research_id: upgraded_research.id })
  end

  def upgrade_defense
    @defense_built = DefenseBuilt.order(updated_at: :desc).first
    upgraded_defense = Defense.find_by(name: @defense_built.defense.name, level: @defense_built.defense.level + 1)
    @defense_built.update({ defense_id: upgraded_defense.id })
  end
end