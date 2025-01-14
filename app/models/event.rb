class Event < ApplicationRecord
  belongs_to :club

  validates :name, presence: true
  validates :start_time, presence: true
  validates :vimeo_video_id, presence: true
end
