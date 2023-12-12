class CreateStructureBuilts < ActiveRecord::Migration[7.1]
  def change
    create_table :structure_builts do |t|
      t.references :town, null: false, foreign_key: true
      t.references :structure, null: false, foreign_key: true

      t.timestamps
    end
  end
end
