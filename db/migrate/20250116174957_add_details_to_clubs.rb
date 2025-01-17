class AddDetailsToClubs < ActiveRecord::Migration[7.0]
  def change
    add_column :clubs, :adresse, :string
    add_column :clubs, :code_postal, :string
    add_column :clubs, :ville, :string
    add_column :clubs, :telephone, :string
    add_column :clubs, :latitude, :float
    add_column :clubs, :longitude, :float
  end
end
