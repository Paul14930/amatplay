class ContactClubsController < ApplicationController
  before_action :set_club
  before_action :set_contact_club, only: %i[show edit update destroy]

  # GET /clubs/:club_id/contact_clubs
  def index
    @contact_clubs = @club.contact_clubs
  end

  # GET /clubs/:club_id/contact_clubs/:id
  def show
  end

  # GET /clubs/:club_id/contact_clubs/new
  def new
    @contact_club = @club.contact_clubs.new
  end

  # POST /clubs/:club_id/contact_clubs
  def create
    @contact_club = @club.contact_clubs.new(contact_club_params)

    if @contact_club.save
      redirect_to [@club, @contact_club], notice: 'Le contact a été créé avec succès.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /clubs/:club_id/contact_clubs/:id/edit
  def edit
  end

  # PATCH/PUT /clubs/:club_id/contact_clubs/:id
  def update
    if @contact_club.update(contact_club_params)
      redirect_to [@club, @contact_club], notice: 'Le contact a été mis à jour avec succès.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /clubs/:club_id/contact_clubs/:id
  def destroy
    @contact_club.destroy
    redirect_to club_contact_clubs_path(@club), notice: 'Le contact a été supprimé avec succès.'
  end

  private

  # Set le club parent
  def set_club
    @club = Club.find(params[:club_id])
  end

  # Set le contact club
  def set_contact_club
    @contact_club = @club.contact_clubs.find(params[:id])
  end

  # Strong parameters
  def contact_club_params
    params.require(:contact_club).permit(:nom, :prenom, :telephone, :mail, :civilite, :qualite)
  end
end
