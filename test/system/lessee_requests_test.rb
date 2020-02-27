require "application_system_test_case"

class LesseeRequestsTest < ApplicationSystemTestCase
  setup do
    @lessee_request = lessee_requests(:one)
  end

  test "visiting the index" do
    visit lessee_requests_url
    assert_selector "h1", text: "Lessee Requests"
  end

  test "creating a Lessee request" do
    visit lessee_requests_url
    click_on "New Lessee Request"

    check "Balcony" if @lessee_request.balcony
    fill_in "City", with: @lessee_request.city_id
    fill_in "Country", with: @lessee_request.country_id
    fill_in "Duration unit", with: @lessee_request.duration_unit
    fill_in "Earliest movein date", with: @lessee_request.earliest_movein_date
    fill_in "Latest movein date", with: @lessee_request.latest_movein_date
    fill_in "Latitude", with: @lessee_request.latitude
    fill_in "Lessee", with: @lessee_request.lessee_id
    fill_in "Longitude", with: @lessee_request.longitude
    fill_in "Max duration", with: @lessee_request.max_duration
    fill_in "Max n housemates", with: @lessee_request.max_n_housemates
    fill_in "Max n roommates", with: @lessee_request.max_n_roommates
    fill_in "Max rent", with: @lessee_request.max_rent
    fill_in "Max rent currency", with: @lessee_request.max_rent_currency
    fill_in "Max rent unit", with: @lessee_request.max_rent_unit
    fill_in "Min duration", with: @lessee_request.min_duration
    check "Private bath" if @lessee_request.private_bath
    fill_in "Radius", with: @lessee_request.radius
    fill_in "Roommate gender", with: @lessee_request.roommate_gender
    check "Smoke" if @lessee_request.smoke
    fill_in "State", with: @lessee_request.state_id
    click_on "Create Lessee request"

    assert_text "Lessee request was successfully created"
    click_on "Back"
  end

  test "updating a Lessee request" do
    visit lessee_requests_url
    click_on "Edit", match: :first

    check "Balcony" if @lessee_request.balcony
    fill_in "City", with: @lessee_request.city_id
    fill_in "Country", with: @lessee_request.country_id
    fill_in "Duration unit", with: @lessee_request.duration_unit
    fill_in "Earliest movein date", with: @lessee_request.earliest_movein_date
    fill_in "Latest movein date", with: @lessee_request.latest_movein_date
    fill_in "Latitude", with: @lessee_request.latitude
    fill_in "Lessee", with: @lessee_request.lessee_id
    fill_in "Longitude", with: @lessee_request.longitude
    fill_in "Max duration", with: @lessee_request.max_duration
    fill_in "Max n housemates", with: @lessee_request.max_n_housemates
    fill_in "Max n roommates", with: @lessee_request.max_n_roommates
    fill_in "Max rent", with: @lessee_request.max_rent
    fill_in "Max rent currency", with: @lessee_request.max_rent_currency
    fill_in "Max rent unit", with: @lessee_request.max_rent_unit
    fill_in "Min duration", with: @lessee_request.min_duration
    check "Private bath" if @lessee_request.private_bath
    fill_in "Radius", with: @lessee_request.radius
    fill_in "Roommate gender", with: @lessee_request.roommate_gender
    check "Smoke" if @lessee_request.smoke
    fill_in "State", with: @lessee_request.state_id
    click_on "Update Lessee request"

    assert_text "Lessee request was successfully updated"
    click_on "Back"
  end

  test "destroying a Lessee request" do
    visit lessee_requests_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Lessee request was successfully destroyed"
  end
end
