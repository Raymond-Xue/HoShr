require 'test_helper'

class LessorRequestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @lessor_request = lessor_requests(:one)
  end

  test "should get index" do
    get lessor_requests_url
    assert_response :success
  end

  test "should get new" do
    get new_lessor_request_url
    assert_response :success
  end

  test "should create lessor_request" do
    assert_difference('LessorRequest.count') do
      post lessor_requests_url, params: { lessor_request: { earliest_movein_date: @lessor_request.earliest_movein_date, min_duration: @lessor_request.min_duration, property_id: @lessor_request.property_id, total_rent: @lessor_request.total_rent, total_rent_currency: @lessor_request.total_rent_currency } }
    end

    assert_redirected_to lessor_request_url(LessorRequest.last)
  end

  test "should show lessor_request" do
    get lessor_request_url(@lessor_request)
    assert_response :success
  end

  test "should get edit" do
    get edit_lessor_request_url(@lessor_request)
    assert_response :success
  end

  test "should update lessor_request" do
    patch lessor_request_url(@lessor_request), params: { lessor_request: { earliest_movein_date: @lessor_request.earliest_movein_date, min_duration: @lessor_request.min_duration, property_id: @lessor_request.property_id, total_rent: @lessor_request.total_rent, total_rent_currency: @lessor_request.total_rent_currency } }
    assert_redirected_to lessor_request_url(@lessor_request)
  end

  test "should destroy lessor_request" do
    assert_difference('LessorRequest.count', -1) do
      delete lessor_request_url(@lessor_request)
    end

    assert_redirected_to lessor_requests_url
  end
end
