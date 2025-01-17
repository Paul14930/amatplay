class DropContactsClubTable < ActiveRecord::Migration[7.0]
  def up
    drop_table :contacts_club
  end

  def down
    create_table :contacts_club do |t|
      t.integer :club_id, null: false
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
