class AddImageIdToClubs < ActiveRecord::Migration[7.0]
  def change
    add_column :clubs, :image_id, :string
  end
end
