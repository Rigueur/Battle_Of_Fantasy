class AddImageUrlToBattles < ActiveRecord::Migration[7.1]
  def change
    add_column :battles, :image_url, :string
  end
end
