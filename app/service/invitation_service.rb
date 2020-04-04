module InvitationService
  include GroupService

  def create_invitation_request(creator_id, group_from_id, group_to_id)
    user = User.find(creator_id)
    if user.nil?
      raise "No such user"
    end
    invitation_id = create_invitation(group_from_id, group_to_id)

    invitation = Invitation.find(invitation_id)
    agree_on_send_invitation(creator_id, invitation_id)
    return invitation.id
  end

  def agree_on_send_invitation(user_id, invitation_id)
    user = User.find(user_id)
    if user.nil?
      raise "No such user"
    end
    invitation = Invitation.find(invitation_id)
    if invitation.nil?
      raise "No such invitation"
    end
    if user.current_group_id != invitation.group_from_id
      raise "Illegal request"
    end
    agree_id = agree_with_invitation(user_id, invitation_id)
    if user.current_group.users.count == invitation.agree_on_invitations.count
      invitation.agree_on_invitations.destroy_all
      invitation.active = true
      invitation.save
    end
    return agree_id

  end

  def agree_on_accept_invitation(user_id, invitation_id)
    user = User.find(user_id)
    if user.nil?
      raise "No such user"
    end
    invitation = Invitation.find(invitation_id)
    if invitation.nil?
      raise "No such invitation"
    end
    if user.current_group_id != invitation.group_to_id
      raise "Illegal request"
    end
    agree_id = nil
    AgreeOnInvitation.transaction do
      agree_id = agree_with_invitation(user_id, invitation_id)
      if user.current_group.users.count == invitation.agree_on_invitations.count
        invitation.agree_on_invitations.destroy_all
        accept_invitation(invitation_id)
      end
    end
    return agree_id
  end

  def find_received_invitation_of_group(group_id)
    Invitation.find_by(group_to_id: group_id, active: true)
  end

  def find_send_invitation_of_group(group_id)
    Invitation.find_by(group_from_id: group_id)
  end

  private

  def create_invitation(group_from_id, group_to_id)

    invitation_id = nil
    state = Invitation.transaction do
      group_from = Group.find_by_id(group_from_id)
      group_to = Group.find_by_id(group_to_id)
      if Invitation.find_by(group_from_id: group_from,
                            group_to_id: group_to).nil? &&
          Invitation.find_by(group_from_id: group_to,
                             group_to_id: group_from).nil?
        invitation = Invitation.new
        invitation.sender = group_from
        invitation.receiver = group_to
        invitation.save
        invitation_id = invitation.id
      end
    end
    if state.nil?
      Group.all
      raise "Fail to add invitation"
    end
    return invitation_id
  end

  def accept_invitation(invitation_id)
    Invitation.transaction do
      invitation = Invitation.find(invitation_id)
      if invitation.nil?
        raise "Invitation not found"
      end
      merge_group(invitation.group_from_id, invitation.group_to_id)
    end
  end

  def agree_with_invitation(user_id, invitation_id)
    user = User.find(user_id)
    if user.nil?
      raise "No such user"
    end
    invitation = Invitation.find(invitation_id)
    if invitation.nil?
      raise "No such invitation"
    end
    agree = AgreeOnInvitation.find_by(invitation_id: invitation_id, user_id: user_id)
    if !agree.nil?
      raise "User already agree on the invitation"
    end
    agree = AgreeOnInvitation.new
    agree.invitation_id = invitation_id
    agree.user_id = user.id
    agree.save
    return agree.id

  end
end


