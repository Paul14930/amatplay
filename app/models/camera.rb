class Camera < ApplicationRecord
  belongs_to :club
  has_many :scheduled_recordings, dependent: :destroy
  validates :live_input_id, presence: true
  validates :rtmp_url, presence: true
  validates :playback_url, presence: true
end
