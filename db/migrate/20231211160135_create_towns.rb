class CreateTowns < ActiveRecord::Migration[7.1]
  def change
    create_table :towns do |t|
      t.text :name
      t.text :coordinates
      t.text :image_url
      t.integer :wood_quantity
      t.integer :stone_quantity
      t.integer :gold_quantity
      t.integer :food_quantity
      t.boolean :research_ongoing
      t.datetime :research_end_time
      t.boolean :construction_ongoing
      t.datetime :construction_end_time
      t.boolean :defense_ongoing
      t.datetime :defense_end_time
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
