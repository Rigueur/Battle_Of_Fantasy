class AddResourcesUpdatedAtToTowns < ActiveRecord::Migration[7.1]
  def change
    add_column :towns, :resources_updated_at, :datetime
  end
end
