class HandleScheduledRecordingJob < ApplicationJob
  queue_as :default

  def perform
    now = Time.current
    ScheduledRecording.where(status: "pending", start_time: ..now).find_each do |recording|
      CloudflareService.new.start_recording(recording.camera.live_input_id)
      recording.update(status: "active")
    end

    ScheduledRecording.where(status: "active", end_time: ..now).find_each do |recording|
      CloudflareService.new.stop_recording(recording.camera.live_input_id)
      recording.update(status: "completed")
    end
  end
end
