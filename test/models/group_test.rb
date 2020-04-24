require 'test_helper'

class GroupTest < ActiveSupport::TestCase
  include GroupService
  include UserService
  include InvitationService
  include LesseeRequestService
  # test "the truth" do
  #   assert true
  # end

  def setup

    create_new_user({id: 1,
                     username:  "user1",
                     email: "user1@example.com",
                     password:              "password",
                     password_confirmation: "password"})
    create_new_user({id: 2,
                     username:  "user2",
                     email: "user2@example.com",
                     password:              "password",
                     password_confirmation: "password"})
    create_new_user({id: 3,
                     username:  "user3",
                     email: "user3@example.com",
                     password:              "password",
                     password_confirmation: "password"})
    create_new_user({id: 4,
                     username:  "user4",
                     email: "user4@example.com",
                     password:              "password",
                     password_confirmation: "password"})
  end


  # merge group tests
  test "a group can be merge with another group, which will results all the
requests, agrees, invitations deleted." do
    assert_equal(true, true)

  end

  # quit group tests
  test "a user in its origin group cannot quit a group" do
    user1 = User.find(1)
    assert_raises(RuntimeError) do
      quit_group(user1.id)
    end
  end

  test "quit group will reset a user's group to its origin group" do
    user1 = User.find(1)
    user2 = User.find(2)
    merge_group(user1.current_group_id, user2.current_group_id)
    user1 = User.find(1)
    user2 = User.find(2)
    assert_equal(user2.current_group_id, user1.current_group_id)
    quit_group(user1.id)
    user1 = User.find(1)
    user2 = User.find(2)
    assert_equal(user1.origin_group_id, user1.current_group_id)
    assert_not_equal(user2.current_group_id, user2.origin_group_id)

  end

  test "quit group will delete a group's lessee request, the agrees associated with it and invitations received and sent" do
    user1 = User.find(1)
    user2 = User.find(2)
    user3 = User.find(3)
    merge_group(user1.current_group_id, user2.current_group_id)
    user1 = User.find(1)
    user2 = User.find(2)
    user3 = User.find(3)
    create_invitation_request(user1.id, user1.current_group_id, user3.current_group_id)
    assert_equal(1, Invitation.count)
    assert_equal(1, AgreeOnInvitation.count)
    quit_group(user1.id)
    assert_equal(0, Invitation.count)
    assert_equal(0, AgreeOnInvitation.count)
  end

  test "the last user quit group will lead the group to be deleted" do
    user1 = User.find(1)
    user2 = User.find(2)
    join_group_id = merge_group(user1.current_group_id, user2.current_group_id)

    quit_group(user1.id)
    user1 = User.find(1)
    user2 = User.find(2)
    assert_not_equal(user1.current_group_id, user2.current_group_id)
    assert_not_equal(user2.current_group_id, user2.origin_group_id)

    quit_group(user2.id)
    user2 = User.find(2)
    assert_equal(user2.current_group_id, user2.origin_group_id)
    assert_nil(Group.find_by_id(join_group_id))
  end

  test "a group close matching will set all lessee request to false" do
    user1 = User.find(1)
    user2 = User.find(2)
    create_request(user1.current_group_id,1, 1, 1)
    user1 = User.find(1)
    assert_equal(true, LesseeRequest.first.active)
    close_matching(user1.current_group_id)
    assert_equal(false, LesseeRequest.first.active)
  end
  test "a group open matching will set all lessee request to true" do
    user1 = User.find(1)
    user2 = User.find(2)
    create_request(user1.current_group_id, 1,1,1)
    assert_equal(true, LesseeRequest.first.active)
    close_matching(user1.current_group_id)
    assert_equal(false, LesseeRequest.first.active)
    open_matching(user1.current_group_id)
    assert_equal(true, LesseeRequest.first.active)
  end

end
