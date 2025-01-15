class ClubsController < ApplicationController
  before_action :set_club, only: [:start_recording, :stop_recording, :show, :edit, :update, :destroy]

  def index
    @clubs = Club.all
  end

  def show
    cloudflare_service = CloudflareService.new
    # @recordings = cloudflare_service.list_recordings(@club.live_input_id)
  end



  def new
    @club = Club.new
  end

  def create
    @club = Club.new(club_params)
    if @club.save
      if params[:club][:image].present?
        file = params[:club][:image].tempfile
        @club.upload_image(file)
      end
      redirect_to @club, notice: 'Club created successfully.'
    else
      render :new
    end
  end

  def update
    if @club.update(club_params)
      if params[:club][:image].present?
        file = params[:club][:image].tempfile
        @club.upload_image(file)
      end
      redirect_to @club, notice: 'Club updated successfully.'
    else
      render :edit
    end
  end





  private

  def set_club
    @club = Club.find(params[:id])
  end

  def club_params
    params.require(:club).permit(:name, :description, :location, :image)
  end
end
