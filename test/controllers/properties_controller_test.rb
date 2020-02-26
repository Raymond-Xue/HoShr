require 'test_helper'

class PropertiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @property = properties(:one)
  end

  test "should get index" do
    get properties_url
    assert_response :success
  end

  test "should get new" do
    get new_property_url
    assert_response :success
  end

  test "should create property" do
    assert_difference('Property.count') do
      post properties_url, params: { property: { city_id: @property.city_id, country_id: @property.country_id, hasAirConditioning: @property.hasAirConditioning, hasKitchen: @property.hasKitchen, hasSmokeDetector: @property.hasSmokeDetector, latitude: @property.latitude, longitude: @property.longitude, n_bathrooms: @property.n_bathrooms, n_bedrooms: @property.n_bedrooms, owner_id: @property.owner_id, state_id: @property.state_id, street_address: @property.street_address, type_id: @property.type_id } }
    end

    assert_redirected_to property_url(Property.last)
  end

  test "should show property" do
    get property_url(@property)
    assert_response :success
  end

  test "should get edit" do
    get edit_property_url(@property)
    assert_response :success
  end

  test "should update property" do
    patch property_url(@property), params: { property: { city_id: @property.city_id, country_id: @property.country_id, hasAirConditioning: @property.hasAirConditioning, hasKitchen: @property.hasKitchen, hasSmokeDetector: @property.hasSmokeDetector, latitude: @property.latitude, longitude: @property.longitude, n_bathrooms: @property.n_bathrooms, n_bedrooms: @property.n_bedrooms, owner_id: @property.owner_id, state_id: @property.state_id, street_address: @property.street_address, type_id: @property.type_id } }
    assert_redirected_to property_url(@property)
  end

  test "should destroy property" do
    assert_difference('Property.count', -1) do
      delete property_url(@property)
    end

    assert_redirected_to properties_url
  end
end
