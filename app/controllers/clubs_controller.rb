class ClubsController < ApplicationController
  before_action :set_club, only: [:start_recording, :stop_recording, :show, :edit, :update, :destroy]

  def index
    @clubs = Club.all
  end

  def show
    cloudflare_service = CloudflareService.new
    @recordings = cloudflare_service.list_recordings(@club.live_input_id)
  end



  def new
    @club = Club.new
  end

  def create
    cloudflare_service = CloudflareService.new

    # Créer un flux RTMP sur Cloudflare
    response = cloudflare_service.create_live_input(params[:club][:name])

    Rails.logger.debug("Cloudflare API Response: #{response.parsed_response.inspect}")

    if response.code == 200 && response.parsed_response["result"].present?
      input_data = response.parsed_response["result"]

      rtmp_url = input_data.dig("rtmps", "url")
      stream_key = input_data.dig("rtmps", "streamKey")
      playback_url = input_data.dig("webRTCPlayback", "url")

      @club = Club.new(club_params.merge(
        live_input_id: input_data["uid"],
        rtmp_url: "#{rtmp_url}#{stream_key}",
        playback_url: playback_url
      ))

      if @club.save
        redirect_to @club, notice: "Le club et son flux vidéo ont été créés avec succès."
      else
        # Log des erreurs ActiveRecord
        Rails.logger.error("Erreur lors de la création du club: #{@club.errors.full_messages.join(', ')}")
        flash[:error] = "Erreur lors de la création du club : #{@club.errors.full_messages.join(', ')}"
        render :new
      end
    else
      error_message = response.parsed_response.dig("errors") || "Erreur inconnue avec Cloudflare"
      flash[:error] = "Erreur lors de la configuration du flux Cloudflare : #{error_message}"
      render :new
    end
  end


  def start_recording
    cloudflare_service = CloudflareService.new
    response = cloudflare_service.start_recording(@club.live_input_id)

    if response.code == 200
      flash[:notice] = "L'enregistrement a démarré avec succès."
    else
      error_message = response.parsed_response.dig("errors") || "Erreur inconnue."
      flash[:alert] = "Impossible de démarrer l'enregistrement : #{error_message}"
    end

    redirect_to @club
  end

  def stop_recording
    cloudflare_service = CloudflareService.new
    response = cloudflare_service.stop_recording(@club.live_input_id)

    if response.code == 200
      flash[:notice] = "L'enregistrement a été arrêté avec succès."
    else
      error_message = response.parsed_response.dig("errors") || "Erreur inconnue."
      flash[:alert] = "Impossible d'arrêter l'enregistrement : #{error_message}"
    end

    redirect_to @club
  end


  private

  def set_club
    @club = Club.find(params[:id])
  end

  def club_params
    params.require(:club).permit(:name, :description, :location)
  end
end
