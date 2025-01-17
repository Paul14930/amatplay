class ClubsController < ApplicationController
  before_action :set_club, only: [:start_recording, :stop_recording, :show, :edit, :update, :destroy]

  def index
    @clubs = Club.all
  end

  def show
    cloudflare_service = CloudflareService.new
    # @recordings = cloudflare_service.list_recordings(@club.live_input_id)
    @contact_clubs = @club.contact_clubs
  end



  def new
    @club = Club.new
  end

  def create
    @club = Club.new(club_params)
    if @club.save
      if params[:club][:image].present?
        Rails.logger.info("Uploading image: #{params[:club][:image].original_filename}")
        file = params[:club][:image].tempfile
        @club.upload_image(file)
      end
      redirect_to @club, notice: 'Club created successfully.'
    else
      Rails.logger.error("Failed to save club: #{@club.errors.full_messages.join(', ')}")
      render :new
    end
  end

  def update
    Rails.logger.info("Updating club with ID: #{@club.id}")
    if @club.update(club_params)
      if params[:club][:image].present?
        Rails.logger.info("Uploading image for club: #{@club.id}")
        file = params[:club][:image].tempfile
        @club.upload_image(file)
      end
      redirect_to @club, notice: 'Club updated successfully.'
    else
      Rails.logger.error("Failed to update club: #{@club.errors.full_messages}")
      render :edit
    end
  end






  private

  def set_club
    @club = Club.find(params[:id])
  end

  def club_params
    params.require(:club).permit(
      :name,
      :description,
      :location,
      :live_input_id,
      :rtmp_url,
      :playback_url,
      :image_id,
      :adresse,
      :code_postal,
      :ville,
      :telephone,
      :latitude,
      :longitude,
      :image
    )
  end
end
