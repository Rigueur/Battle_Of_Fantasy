class AddParametersToUsers < ActiveRecord::Migration[7.1]
  def change
    add column :users, :username, :string
    add column :users, :avatar_url, :string
    add column :users, :nickname, :string
    add column :users, :level, :integer
    add column :users, :experience, :integer
    add column :users, :energy, :integer
  end
end
