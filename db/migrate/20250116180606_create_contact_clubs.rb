class CreateContactClubs < ActiveRecord::Migration[7.0]
  def change
    create_table :contact_clubs do |t|
      t.references :club, null: false, foreign_key: true
      t.string :nom
      t.string :prenom
      t.string :telephone
      t.string :mail
      t.string :civilite
      t.string :qualite

      t.timestamps
    end
  end
end
