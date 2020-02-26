require "application_system_test_case"

class PropertiesTest < ApplicationSystemTestCase
  setup do
    @property = properties(:one)
  end

  test "visiting the index" do
    visit properties_url
    assert_selector "h1", text: "Properties"
  end

  test "creating a Property" do
    visit properties_url
    click_on "New Property"

    fill_in "City", with: @property.city_id
    fill_in "Country", with: @property.country_id
    check "Hasairconditioning" if @property.hasAirConditioning
    check "Haskitchen" if @property.hasKitchen
    check "Hassmokedetector" if @property.hasSmokeDetector
    fill_in "Latitude", with: @property.latitude
    fill_in "Longitude", with: @property.longitude
    fill_in "N bathroom", with: @property.n_bathroom
    fill_in "N bedrooms", with: @property.n_bedrooms
    fill_in "Owner", with: @property.owner_id
    fill_in "State", with: @property.state_id
    fill_in "Street address", with: @property.street_address
    fill_in "Type", with: @property.type_id
    fill_in "Zipcode", with: @property.zipcode
    click_on "Create Property"

    assert_text "Property was successfully created"
    click_on "Back"
  end

  test "updating a Property" do
    visit properties_url
    click_on "Edit", match: :first

    fill_in "City", with: @property.city_id
    fill_in "Country", with: @property.country_id
    check "Hasairconditioning" if @property.hasAirConditioning
    check "Haskitchen" if @property.hasKitchen
    check "Hassmokedetector" if @property.hasSmokeDetector
    fill_in "Latitude", with: @property.latitude
    fill_in "Longitude", with: @property.longitude
    fill_in "N bathroom", with: @property.n_bathroom
    fill_in "N bedrooms", with: @property.n_bedrooms
    fill_in "Owner", with: @property.owner_id
    fill_in "State", with: @property.state_id
    fill_in "Street address", with: @property.street_address
    fill_in "Type", with: @property.type_id
    fill_in "Zipcode", with: @property.zipcode
    click_on "Update Property"

    assert_text "Property was successfully updated"
    click_on "Back"
  end

  test "destroying a Property" do
    visit properties_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Property was successfully destroyed"
  end
end
