class AddParametersToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :username, :string
    add_column :users, :avatar_url, :string
    add_column :users, :nickname, :string
    add_column :users, :level, :integer
    add_column :users, :experience, :integer
    add_column :users, :energy, :integer
  end
end
