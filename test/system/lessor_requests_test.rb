require "application_system_test_case"

class LessorRequestsTest < ApplicationSystemTestCase
  setup do
    @lessor_request = lessor_requests(:one)
  end

  test "visiting the index" do
    visit lessor_requests_url
    assert_selector "h1", text: "Lessor Requests"
  end

  test "creating a Lessor request" do
    visit lessor_requests_url
    click_on "New Lessor Request"

    fill_in "Earliest movein date", with: @lessor_request.earliest_movein_date
    fill_in "Min duration", with: @lessor_request.min_duration
    fill_in "Property", with: @lessor_request.property_id
    fill_in "Total rent", with: @lessor_request.total_rent
    fill_in "Total rent currency", with: @lessor_request.total_rent_currency
    click_on "Create Lessor request"

    assert_text "Lessor request was successfully created"
    click_on "Back"
  end

  test "updating a Lessor request" do
    visit lessor_requests_url
    click_on "Edit", match: :first

    fill_in "Earliest movein date", with: @lessor_request.earliest_movein_date
    fill_in "Min duration", with: @lessor_request.min_duration
    fill_in "Property", with: @lessor_request.property_id
    fill_in "Total rent", with: @lessor_request.total_rent
    fill_in "Total rent currency", with: @lessor_request.total_rent_currency
    click_on "Update Lessor request"

    assert_text "Lessor request was successfully updated"
    click_on "Back"
  end

  test "destroying a Lessor request" do
    visit lessor_requests_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Lessor request was successfully destroyed"
  end
end
