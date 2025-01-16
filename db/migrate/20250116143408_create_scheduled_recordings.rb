class CreateScheduledRecordings < ActiveRecord::Migration[7.0]
  def change
    create_table :scheduled_recordings do |t|
      t.references :camera, null: false, foreign_key: true
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false
      t.string :status, default: "pending" # pending, active, completed

      t.timestamps
    end
  end
end
