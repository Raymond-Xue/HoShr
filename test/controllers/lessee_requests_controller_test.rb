require 'test_helper'

class LesseeRequestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @lessee_request = lessee_requests(:one)
  end

  test "should get index" do
    get lessee_requests_url
    assert_response :success
  end

  test "should get new" do
    get new_lessee_request_url
    assert_response :success
  end

  test "should create lessee_request" do
    assert_difference('LesseeRequest.count') do
      post lessee_requests_url, params: { lessee_request: { balcony: @lessee_request.balcony, city_id: @lessee_request.city_id, country_id: @lessee_request.country_id, duration_unit: @lessee_request.duration_unit, earliest_movein_date: @lessee_request.earliest_movein_date, latest_movein_date: @lessee_request.latest_movein_date, latitude: @lessee_request.latitude, lessee_id: @lessee_request.lessee_id, longitude: @lessee_request.longitude, max_duration: @lessee_request.max_duration, max_n_housemates: @lessee_request.max_n_housemates, max_n_roommates: @lessee_request.max_n_roommates, max_rent: @lessee_request.max_rent, max_rent_currency: @lessee_request.max_rent_currency, max_rent_unit: @lessee_request.max_rent_unit, min_duration: @lessee_request.min_duration, private_bath: @lessee_request.private_bath, radius: @lessee_request.radius, roommate_gender: @lessee_request.roommate_gender, smoke: @lessee_request.smoke, state_id: @lessee_request.state_id } }
    end

    assert_redirected_to lessee_request_url(LesseeRequest.last)
  end

  test "should show lessee_request" do
    get lessee_request_url(@lessee_request)
    assert_response :success
  end

  test "should get edit" do
    get edit_lessee_request_url(@lessee_request)
    assert_response :success
  end

  test "should update lessee_request" do
    patch lessee_request_url(@lessee_request), params: { lessee_request: { balcony: @lessee_request.balcony, city_id: @lessee_request.city_id, country_id: @lessee_request.country_id, duration_unit: @lessee_request.duration_unit, earliest_movein_date: @lessee_request.earliest_movein_date, latest_movein_date: @lessee_request.latest_movein_date, latitude: @lessee_request.latitude, lessee_id: @lessee_request.lessee_id, longitude: @lessee_request.longitude, max_duration: @lessee_request.max_duration, max_n_housemates: @lessee_request.max_n_housemates, max_n_roommates: @lessee_request.max_n_roommates, max_rent: @lessee_request.max_rent, max_rent_currency: @lessee_request.max_rent_currency, max_rent_unit: @lessee_request.max_rent_unit, min_duration: @lessee_request.min_duration, private_bath: @lessee_request.private_bath, radius: @lessee_request.radius, roommate_gender: @lessee_request.roommate_gender, smoke: @lessee_request.smoke, state_id: @lessee_request.state_id } }
    assert_redirected_to lessee_request_url(@lessee_request)
  end

  test "should destroy lessee_request" do
    assert_difference('LesseeRequest.count', -1) do
      delete lessee_request_url(@lessee_request)
    end

    assert_redirected_to lessee_requests_url
  end
end
