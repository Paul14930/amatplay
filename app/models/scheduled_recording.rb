class ScheduledRecording < ApplicationRecord
  belongs_to :camera

  validates :start_time, :end_time, presence: true
  validate :end_time_after_start_time

  def end_time_after_start_time
    return if end_time.blank? || start_time.blank?

    errors.add(:end_time, "doit être après la date et heure de début") if end_time <= start_time
  end
end
