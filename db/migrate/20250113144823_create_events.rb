class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :name
      t.datetime :start_time
      t.references :club, null: false, foreign_key: true
      t.string :vimeo_video_id

      t.timestamps
    end
  end
end
