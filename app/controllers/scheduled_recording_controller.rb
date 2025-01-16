class ScheduledRecordingsController < ApplicationController
  def create
    @camera = Camera.find(params[:camera_id])
    @scheduled_recording = @camera.scheduled_recordings.new(scheduled_recording_params)

    if @scheduled_recording.save
      redirect_to @camera, notice: "Enregistrement programmé avec succès."
    else
      redirect_to @camera, alert: "Erreur lors de la programmation : #{@scheduled_recording.errors.full_messages.join(", ")}"
    end
  end

  private

  def scheduled_recording_params
    params.require(:scheduled_recording).permit(:start_time, :end_time)
  end
end
