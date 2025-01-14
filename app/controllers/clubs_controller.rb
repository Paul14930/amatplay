class ClubsController < ApplicationController
  def index
    @clubs = Club.all
  end

  def show
    @club = Club.find(params[:id])
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





  private

  def club_params
    params.require(:club).permit(:name, :description, :location)
  end
end
