class CreateStructures < ActiveRecord::Migration[7.1]
  def change
    create_table :structures do |t|
      t.text :name
      t.text :image_url
      t.integer :level
      t.integer :wood_cost
      t.integer :stone_cost
      t.integer :gold_cost
      t.text :upgrade_time
      t.integer :wood_production
      t.integer :stone_production
      t.string :gold_production
      t.string :food_production

      t.timestamps
    end
  end
end
