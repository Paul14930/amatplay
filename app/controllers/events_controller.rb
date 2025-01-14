class EventsController < ApplicationController
  def index
    @club = Club.find(params[:club_id])
    @events = @club.events
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @club = Club.find(params[:club_id])
    @event = @club.events.build
  end

  def create
    @club = Club.find(params[:club_id])
    @event = @club.events.build(event_params)
    if @event.save
      redirect_to club_events_path(@club), notice: "L'événement a été créé avec succès."
    else
      render :new
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :start_time, :vimeo_video_id)
  end
end
