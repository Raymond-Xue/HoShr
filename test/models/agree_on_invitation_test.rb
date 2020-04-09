require 'test_helper'

class AgreeOnInvitationTest < ActiveSupport::TestCase
  include InvitationService
  include UserService


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

    user3 = User.find(3)
    user4 = User.find(4)
    merge_group(user3.current_group_id, user4.current_group_id)

  end

  test "a group member of one person group can create a invitation request which is active" do
    user1 = User.find(1)
    user2 = User.find(2)
    create_invitation_request(user1.id, user1.current_group_id, user2.current_group_id)
    assert_equal(0, AgreeOnInvitation.count)

    invitation = user1.current_group.send_invitation.first
    assert_equal(true, invitation.active)
    assert_equal(user1.current_group_id, invitation.group_from_id)
    assert_equal(user2.current_group_id, invitation.group_to_id)
  end
  test " one team member of multiple member team can create a invitation request which is inactive" do
    user1 = User.find(1)
    user3 = User.find(3)
    create_invitation_request(user3.id, user3.current_group_id, user1.current_group_id)
    assert_equal(1, user3.agree_on_invitations.count)
    assert_equal(1, Invitation.count)
    assert_equal(false, user3.agreed_invitations.sample.active)

  end
  test " one group member of two people group can create a invitation request,
other member can agree the request" do
    user1 = User.find(1)
    user4 = User.find(4)
    user3 = User.find(3)
    invitation_id = create_invitation_request(user3.id, user3.current_group_id, user1.current_group_id)
    assert_equal(1, user3.agree_on_invitations.count)
    assert_equal(1, Invitation.count)
    assert_equal(false, user3.agreed_invitations.sample.active)

    agree_on_send_invitation(user4.id, invitation_id)
    assert_equal(0, AgreeOnInvitation.count)
    assert_equal(1, Invitation.count)
    assert_equal(true, Invitation.all.sample.active)
  end
  test "invitation receiver can agree on the received invitation to merge " do
    user1 = User.find(1)
    user3 = User.find(3)
    user4 = User.find(4)

    invitation_id = create_invitation_request(user3.id, user3.current_group_id, user1.current_group_id)
    agree_on_send_invitation(user4.id, invitation_id)
    assert_equal(0, AgreeOnInvitation.count)
    assert_equal(1, Invitation.count)

    assert_equal(1, user1.current_group.received_invitation.count)
    invitation = Invitation.find(invitation_id)
    agree_on_accept_invitation(user1.id, invitation.id)
    assert_equal(0, AgreeOnInvitation.count)
    assert_equal(0, Invitation.count)

    user1 = User.find(1)
    user3 = User.find(3)
    user4 = User.find(4)

    assert_equal(user1.current_group.id, user3.current_group.id)
    assert_equal(user1.current_group.id, user4.current_group.id)
  end
  test "all invitation receiver must agree on the received invitation to merge " do
    user1 = User.find(1)
    user3 = User.find(3)
    user4 = User.find(4)

    invitation_id = create_invitation_request(user1.id, user1.current_group_id, user3.current_group_id)
    assert_equal(0, AgreeOnInvitation.count)
    assert_equal(1, Invitation.count)

    assert_equal(1, user3.current_group.received_invitation.count)
    invitation = Invitation.find(invitation_id)
    agree_on_accept_invitation(user3.id, invitation.id)

    assert_equal(1, AgreeOnInvitation.count)
    assert_equal(1, Invitation.count)
    agree_on_accept_invitation(user4.id, invitation.id)

    user1 = User.find(1)
    user3 = User.find(3)
    user4 = User.find(4)

    assert_equal(user1.current_group.id, user3.current_group.id)
    assert_equal(user1.current_group.id, user4.current_group.id)
  end
end
