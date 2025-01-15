class RemoveImageFromClubs < ActiveRecord::Migration[7.0]
  def change
    remove_column :clubs, :image, :string
  end
end
