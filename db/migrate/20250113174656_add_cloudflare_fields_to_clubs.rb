class AddCloudflareFieldsToClubs < ActiveRecord::Migration[7.0]
  def change
    add_column :clubs, :live_input_id, :string
    add_column :clubs, :rtmp_url, :string
    add_column :clubs, :playback_url, :string
  end
end
