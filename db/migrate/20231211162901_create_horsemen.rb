class CreateHorsemen < ActiveRecord::Migration[7.1]
  def change
    create_table :horsemen do |t|
      t.references :homebase, null: false, foreign_key: true
      t.text :name
      t.text :image_url
      t.integer :level
      t.integer :hp
      t.text :armor_type
      t.integer :attack
      t.text :attack_type
      t.integer :speed
      t.integer :stealth
      t.integer :gold_recruit_cost
      t.integer :food_recruit_cost
      t.integer :energy_recruit_cost
      t.integer :gold_train_cost
      t.integer :food_train_cost
      t.string :energy_train_cost
      t.boolean :enrolled

      t.timestamps
    end
  end
end
