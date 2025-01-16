class HandleScheduledRecordingJob < ApplicationJob
  queue_as :default

  def perform
    Rails.logger.info "Starting HandleScheduledRecordingJob at #{Time.current}"

    now = Time.current

    # Tolérance pour ne pas rater les enregistrements proches des limites
    ScheduledRecording.where(status: "pending", start_time: ..(now + 10.minutes)).find_each do |recording|
      Rails.logger.info "Starting recording for camera #{recording.camera.id}"
      CloudflareService.new.start_recording(recording.camera.live_input_id)
      recording.update(status: "active")
    end

    ScheduledRecording.where(status: "active", end_time: ..now).find_each do |recording|
      Rails.logger.info "Stopping recording for camera #{recording.camera.id}"
      CloudflareService.new.stop_recording(recording.camera.live_input_id)
      recording.update(status: "completed")
    end

    Rails.logger.info "Completed HandleScheduledRecordingJob at #{Time.current}"
  end
end
