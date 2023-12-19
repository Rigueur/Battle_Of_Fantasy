class ChangeMessages < ActiveRecord::Migration[6.0]
  def change
    remove_reference :messages, :sender, index: true, foreign_key: { to_table: :users }
    remove_reference :messages, :receiver, index: true, foreign_key: { to_table: :users }
    add_reference :messages, :chatroom, null: false, foreign_key: true
    add_reference :messages, :user, null: false, foreign_key: true
  end
end
