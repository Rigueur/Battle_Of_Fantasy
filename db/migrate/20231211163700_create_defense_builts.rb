class CreateDefenseBuilts < ActiveRecord::Migration[7.1]
  def change
    create_table :defense_builts do |t|
      t.references :homebase, null: false, foreign_key: true
      t.references :defense, null: false, foreign_key: true

      t.timestamps
    end
  end
end
