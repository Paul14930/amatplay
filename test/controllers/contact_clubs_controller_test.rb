require "test_helper"

class ContactClubsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @contact_club = contact_clubs(:one)
  end

  test "should get index" do
    get contact_clubs_url
    assert_response :success
  end

  test "should get new" do
    get new_contact_club_url
    assert_response :success
  end

  test "should create contact_club" do
    assert_difference("ContactClub.count") do
      post contact_clubs_url, params: { contact_club: { civilite: @contact_club.civilite, club_id: @contact_club.club_id, mail: @contact_club.mail, nom: @contact_club.nom, prenom: @contact_club.prenom, qualite: @contact_club.qualite, telephone: @contact_club.telephone } }
    end

    assert_redirected_to contact_club_url(ContactClub.last)
  end

  test "should show contact_club" do
    get contact_club_url(@contact_club)
    assert_response :success
  end

  test "should get edit" do
    get edit_contact_club_url(@contact_club)
    assert_response :success
  end

  test "should update contact_club" do
    patch contact_club_url(@contact_club), params: { contact_club: { civilite: @contact_club.civilite, club_id: @contact_club.club_id, mail: @contact_club.mail, nom: @contact_club.nom, prenom: @contact_club.prenom, qualite: @contact_club.qualite, telephone: @contact_club.telephone } }
    assert_redirected_to contact_club_url(@contact_club)
  end

  test "should destroy contact_club" do
    assert_difference("ContactClub.count", -1) do
      delete contact_club_url(@contact_club)
    end

    assert_redirected_to contact_clubs_url
  end
end
