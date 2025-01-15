class CamerasController < ApplicationController
  before_action :set_club
  before_action :set_camera, only: [:show, :start_recording, :stop_recording, :destroy]

  def new
    @camera = @club.cameras.new
  end

  def create
    cloudflare_service = CloudflareService.new

    # Créer un flux RTMP sur Cloudflare
    response = cloudflare_service.create_live_input(params[:camera][:name])

    if response.code == 200 && response.parsed_response["result"].present?
      input_data = response.parsed_response["result"]

      @camera = @club.cameras.new(
        live_input_id: input_data["uid"],
        rtmp_url: "#{input_data.dig("rtmps", "url")}#{input_data.dig("rtmps", "streamKey")}",
        playback_url: input_data.dig("webRTCPlayback", "url")
      )

      if @camera.save
        redirect_to @club, notice: "Caméra ajoutée avec succès."
      else
        flash[:error] = "Erreur lors de la création de la caméra : #{@camera.errors.full_messages.join(', ')}"
        render :new
      end
    else
      error_message = response.parsed_response.dig("errors") || "Erreur inconnue avec Cloudflare"
      flash[:error] = "Erreur lors de la configuration du flux Cloudflare : #{error_message}"
      render :new
    end
  end

  def show
    @camera = Camera.find(params[:id])
    cloudflare_service = CloudflareService.new

    # Récupérer les enregistrements
    @recordings = cloudflare_service.list_recordings(@camera.live_input_id)
  end



  def list_recordings_with_cache(input_id)
    Rails.cache.fetch("live_input_videos_#{input_id}", expires_in: 10.minutes, race_condition_ttl: 30) do
      list_recordings(input_id)
    end
  end


  def start_recording
    cloudflare_service = CloudflareService.new
    response = cloudflare_service.start_recording(@camera.live_input_id)

    if response.code == 200
      flash[:notice] = "L'enregistrement a démarré avec succès."
    else
      error_message = response.parsed_response.dig("errors") || "Erreur inconnue."
      flash[:alert] = "Impossible de démarrer l'enregistrement : #{error_message}"
    end

    redirect_to club_camera_path(@camera.club, @camera)
  end

  def stop_recording
    cloudflare_service = CloudflareService.new
    response = cloudflare_service.stop_recording(@camera.live_input_id)

    if response.code == 200
      flash[:notice] = "L'enregistrement a été arrêté avec succès."
    else
      error_message = response.parsed_response.dig("errors") || "Erreur inconnue."
      flash[:alert] = "Impossible d'arrêter l'enregistrement : #{error_message}"
    end

    redirect_to club_camera_path(@camera.club, @camera)
  end

  def destroy
    @camera.destroy
    redirect_to @club, notice: "Caméra supprimée avec succès."
  end

  private

  def set_club
    @club = Club.find(params[:club_id])
  end

  def set_camera
    @camera = @club.cameras.find(params[:id])
  end

  def camera_params
    params.require(:camera).permit(:name)
  end
end
