require "application_system_test_case"

class CitiesTest < ApplicationSystemTestCase
  setup do
    @city = cities(:one)
  end

  test "visiting the index" do
    visit cities_url
    assert_selector "h1", text: "Cities"
  end

  test "creating a City" do
    visit cities_url
    click_on "New City"

    fill_in "City name", with: @city.city_name
    fill_in "Country", with: @city.country_id
    fill_in "Max latitude", with: @city.max_latitude
    fill_in "Max longitude", with: @city.max_longitude
    fill_in "Min latitude", with: @city.min_latitude
    fill_in "Min longitude", with: @city.min_longitude
    fill_in "State", with: @city.state_id
    click_on "Create City"

    assert_text "City was successfully created"
    click_on "Back"
  end

  test "updating a City" do
    visit cities_url
    click_on "Edit", match: :first

    fill_in "City name", with: @city.city_name
    fill_in "Country", with: @city.country_id
    fill_in "Max latitude", with: @city.max_latitude
    fill_in "Max longitude", with: @city.max_longitude
    fill_in "Min latitude", with: @city.min_latitude
    fill_in "Min longitude", with: @city.min_longitude
    fill_in "State", with: @city.state_id
    click_on "Update City"

    assert_text "City was successfully updated"
    click_on "Back"
  end

  test "destroying a City" do
    visit cities_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "City was successfully destroyed"
  end
end
