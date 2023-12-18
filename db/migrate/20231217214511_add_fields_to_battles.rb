class AddFieldsToBattles < ActiveRecord::Migration[7.1]
  def change
    add_column :battles, :attacking_units_lost, :text
    add_column :battles, :defending_units_lost, :text
    add_column :battles, :resources_won, :text
  end
end
