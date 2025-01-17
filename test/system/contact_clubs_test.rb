require "application_system_test_case"

class ContactClubsTest < ApplicationSystemTestCase
  setup do
    @contact_club = contact_clubs(:one)
  end

  test "visiting the index" do
    visit contact_clubs_url
    assert_selector "h1", text: "Contact clubs"
  end

  test "should create contact club" do
    visit contact_clubs_url
    click_on "New contact club"

    fill_in "Civilite", with: @contact_club.civilite
    fill_in "Club", with: @contact_club.club_id
    fill_in "Mail", with: @contact_club.mail
    fill_in "Nom", with: @contact_club.nom
    fill_in "Prenom", with: @contact_club.prenom
    fill_in "Qualite", with: @contact_club.qualite
    fill_in "Telephone", with: @contact_club.telephone
    click_on "Create Contact club"

    assert_text "Contact club was successfully created"
    click_on "Back"
  end

  test "should update Contact club" do
    visit contact_club_url(@contact_club)
    click_on "Edit this contact club", match: :first

    fill_in "Civilite", with: @contact_club.civilite
    fill_in "Club", with: @contact_club.club_id
    fill_in "Mail", with: @contact_club.mail
    fill_in "Nom", with: @contact_club.nom
    fill_in "Prenom", with: @contact_club.prenom
    fill_in "Qualite", with: @contact_club.qualite
    fill_in "Telephone", with: @contact_club.telephone
    click_on "Update Contact club"

    assert_text "Contact club was successfully updated"
    click_on "Back"
  end

  test "should destroy Contact club" do
    visit contact_club_url(@contact_club)
    click_on "Destroy this contact club", match: :first

    assert_text "Contact club was successfully destroyed"
  end
end
