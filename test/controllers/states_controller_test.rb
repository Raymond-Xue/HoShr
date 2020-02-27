require 'test_helper'

class StatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @state = states(:one)
  end

  test "should get index" do
    get states_url
    assert_response :success
  end

  test "should get new" do
    get new_state_url
    assert_response :success
  end

  test "should create state" do
    assert_difference('State.count') do
      post states_url, params: { state: { country_id: @state.country_id, max_latitude: @state.max_latitude, max_longitude: @state.max_longitude, min_latitude: @state.min_latitude, min_longitude: @state.min_longitude, state_name: @state.state_name } }
    end

    assert_redirected_to state_url(State.last)
  end

  test "should show state" do
    get state_url(@state)
    assert_response :success
  end

  test "should get edit" do
    get edit_state_url(@state)
    assert_response :success
  end

  test "should update state" do
    patch state_url(@state), params: { state: { country_id: @state.country_id, max_latitude: @state.max_latitude, max_longitude: @state.max_longitude, min_latitude: @state.min_latitude, min_longitude: @state.min_longitude, state_name: @state.state_name } }
    assert_redirected_to state_url(@state)
  end

  test "should destroy state" do
    assert_difference('State.count', -1) do
      delete state_url(@state)
    end

    assert_redirected_to states_url
  end
end
