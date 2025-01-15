class CreateCameras < ActiveRecord::Migration[7.0]
  def change
    create_table :cameras do |t|
      t.string :name
      t.string :live_input_id
      t.string :rtmp_url
      t.string :playback_url
      t.references :club, null: false, foreign_key: true

      t.timestamps
    end
  end
end
