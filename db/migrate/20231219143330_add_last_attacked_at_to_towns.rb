class AddLastAttackedAtToTowns < ActiveRecord::Migration[7.1]
  def change
    add_column :towns, :last_attacked_at, :datetime
  end
end
