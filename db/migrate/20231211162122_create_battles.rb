class CreateBattles < ActiveRecord::Migration[7.1]
  def change
    create_table :battles do |t|
      t.integer :energy_cost
      t.text :result
      t.references :attacking_base, null: false,  foreign_key: { to_table: :users }
      t.references :defending_base, null: false,  foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
