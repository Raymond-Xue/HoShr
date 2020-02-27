require 'test_helper'

class RoomsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @room = rooms(:one)
  end

  test "should get index" do
    get rooms_url
    assert_response :success
  end

  test "should get new" do
    get new_room_url
    assert_response :success
  end

  test "should create room" do
    assert_difference('Room.count') do
      post rooms_url, params: { room: { area: @room.area, area_unit: @room.area_unit, hasBalcony: @room.hasBalcony, hasPrivateBath: @room.hasPrivateBath, property_id: @room.property_id, room_id: @room.room_id, status: @room.status } }
    end

    assert_redirected_to room_url(Room.last)
  end

  test "should show room" do
    get room_url(@room)
    assert_response :success
  end

  test "should get edit" do
    get edit_room_url(@room)
    assert_response :success
  end

  test "should update room" do
    patch room_url(@room), params: { room: { area: @room.area, area_unit: @room.area_unit, hasBalcony: @room.hasBalcony, hasPrivateBath: @room.hasPrivateBath, property_id: @room.property_id, room_id: @room.room_id, status: @room.status } }
    assert_redirected_to room_url(@room)
  end

  test "should destroy room" do
    assert_difference('Room.count', -1) do
      delete room_url(@room)
    end

    assert_redirected_to rooms_url
  end
end
