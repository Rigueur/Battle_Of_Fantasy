class CreateResearches < ActiveRecord::Migration[7.1]
  def change
    create_table :researches do |t|
      t.text :name
      t.text :image_url
      t.integer :level
      t.integer :wood_cost
      t.integer :stone_cost
      t.integer :gold_cost
      t.text :upgrade_time
      t.text :effect

      t.timestamps
    end
  end
end
