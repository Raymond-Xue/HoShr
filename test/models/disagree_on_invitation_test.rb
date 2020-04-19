require 'test_helper'

class DisagreeOnInvitationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
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
  test "a member of a group can disagree on an invitation" do
    user1 = User.find(1)
    user3 = User.find(3)
    user4 = User.find(4)

    invitation_id = create_invitation_request(user3.id, user3.current_group_id, user1.current_group)
    disagree_on_send_invitation(user4.id, invitation_id)
    user4 = User.find(4)
    assert_equal(1, DisagreeOnInvitation.count)
    assert_equal(1, user4.disagree_on_invitations.count)
  end

  test "a member of a group can cancel the opinion he had on an invitation" do
    user1 = User.find(1)
    user2 = User.find(2)
    user3 = User.find(3)
    user4 = User.find(4)

    invitation_id = create_invitation_request(user3.id, user3.current_group_id, user1.current_group_id)
    invitation = Invitation.find(invitation_id)
    disagree_on_send_invitation(user4.id, invitation_id)
    assert_equal(1, user4.disagree_on_invitations.count)
    destroy_agree_disagree(user4.id, invitation_id)
    assert_equal(0, DisagreeOnInvitation.count)
    assert_equal(1, AgreeOnInvitation.count)
  end
  test "all member of a group disagree on an invitation will delete the invitation request" do
    user1 = User.find(1)
    user2 = User.find(2)
    user3 = User.find(3)
    user4 = User.find(4)

    invitation_id = create_invitation_request(user1.id, user1.current_group_id, user3.current_group_id)
    assert_equal(1, Invitation.count)

    disagree_on_accept_invitation(user3.id, invitation_id)
    assert_equal(1, Invitation.count)
    assert_equal(1, DisagreeOnInvitation.count)
    disagree_on_accept_invitation(user4.id, invitation_id)
    assert_equal(0, Invitation.count)
    assert_equal(0, DisagreeOnInvitation.count)

    invitation_id = create_invitation_request(user3.id, user3.current_group_id, user1.current_group_id)
    assert_equal(1, Invitation.count)
    destroy_agree_disagree(user3, invitation_id)
    disagree_on_send_invitation(user3.id, invitation_id)
    assert_equal(1, DisagreeOnInvitation.count)
    disagree_on_send_invitation(user4.id, invitation_id)
    assert_equal(0, Invitation.count)
    assert_equal(0, DisagreeOnInvitation.count)
  end

  test "user can withdraw their agree / disagree" do
    user1 = User.find(1)
    user2 = User.find(2)
    user3 = User.find(3)
    user4 = User.find(4)

    invitation_id = create_invitation_request(user2.id, user2.current_group_id, user3.current_group_id)

    disagree_on_accept_invitation(user3.id, invitation_id)
    assert_equal(1, DisagreeOnInvitation.count)
    destroy_agree_disagree(user3.id, invitation_id)
    assert_equal(0, DisagreeOnInvitation.count)
    invitation_id = create_invitation_request(user3.id, user3.current_group_id, user1.current_group_id)
    assert_equal(1, AgreeOnInvitation.count)
    destroy_agree_disagree(user3.id, invitation_id)
    assert_equal(0, AgreeOnInvitation.count)


  end

end
