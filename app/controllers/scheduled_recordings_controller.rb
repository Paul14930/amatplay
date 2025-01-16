class ScheduledRecordingsController < ApplicationController
  before_action :set_club
  before_action :set_camera

  def create
    @scheduled_recording = @camera.scheduled_recordings.new(scheduled_recording_params)

    if @scheduled_recording.save
      redirect_to club_camera_path(@club, @camera), notice: "Enregistrement programmé avec succès."
    else
      redirect_to club_camera_path(@club, @camera), alert: "Erreur : #{@scheduled_recording.errors.full_messages.join(', ')}"
    end
  end

  private

  def set_club
    @club = Club.find(params[:club_id])
  end

  def set_camera
    @camera = @club.cameras.find(params[:camera_id])
  end

  def scheduled_recording_params
    params.require(:scheduled_recording).permit(:start_time, :end_time)
  end
end
