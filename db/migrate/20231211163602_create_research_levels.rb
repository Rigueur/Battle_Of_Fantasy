class CreateResearchLevels < ActiveRecord::Migration[7.1]
  def change
    create_table :research_levels do |t|
      t.references :homebase, null: false, foreign_key: true
      t.references :research, null: false, foreign_key: true

      t.timestamps
    end
  end
end
