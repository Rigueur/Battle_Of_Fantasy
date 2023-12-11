class CreateMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :messages do |t|
      t.text :content
      t.time :send_time
      t.boolean :read
      t.references :sender_id, null: false,  foreign_key: { to_table: :users }
      t.references :receiver_id, null: false,  foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
