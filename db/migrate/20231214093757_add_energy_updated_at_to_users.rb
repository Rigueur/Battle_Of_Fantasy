class AddEnergyUpdatedAtToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :energy_updated_at, :datetime
  end
end
