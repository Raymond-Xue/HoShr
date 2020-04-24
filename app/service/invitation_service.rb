module InvitationService
  include GroupService

  def create_invitation_request(creator_id, group_from_id, group_to_id)
    user = User.find(creator_id)
    if user.nil?
      raise "No such user"
    end
    invitation_id = nil
    Invitation.transaction do
      invitation_id = create_invitation(group_from_id, group_to_id)
      agree_on_send_invitation(creator_id, invitation_id)
    end
    return invitation_id
  end

  def disagree_on_send_invitation(user_id, invitation_id)
    user = User.find(user_id)
    if user.nil?
      raise "No such user"
    end
    disagree_id = nil
    Invitation.transaction do
      invitation = Invitation.find(invitation_id)
      if invitation.nil?
        raise "No such invitation"
      end
      if user.current_group_id != invitation.group_from_id
        raise "Illegal request"
      end
      if user.agree_on_invitations.find_by(id: invitation_id)
        raise "You have already agree on the invitation"
      end
      if user.disagree_on_invitations.find_by(id: invitation_id)
        raise "You have already disagreed on the invitation"
      end
      disagree_with_invitation(user_id, invitation_id)
      if user.current_group.users.count == invitation.disagree_on_invitations.count
        invitation.disagree_on_invitations.destroy_all
        invitation.destroy
        invitation.save
      end
    end
    return disagree_id
  end

  def disagree_on_accept_invitation(user_id, invitation_id)
    user = User.find(user_id)
    if user.nil?
      raise "No such user"
    end
    state = Invitation.transaction do
      invitation = Invitation.find(invitation_id)
      if invitation.nil?
        raise "No such invitation"
      end
      if user.current_group_id != invitation.group_to_id
        raise "Illegal request"
      end
      if !user.agree_on_invitations.find_by(id: invitation_id).nil?
        raise "You have already agree on the invitation"
      end
      if !user.disagree_on_invitations.find_by(id: invitation_id).nil?
        raise "You have already disagreed on the invitation"
      end
      disagree_with_invitation(user_id, invitation_id)
      if user.current_group.users.count == invitation.disagree_on_invitations.count
        invitation.disagree_on_invitations.destroy_all
        invitation.destroy
        invitation.save
      end
    end
  end

  def destroy_agree_disagree(user_id, invitation_id)
    user = User.find_by(id: user_id)
    if user.nil?
      raise "No such user"
    end
    state = Invitation.transaction do
      invitation = Invitation.find(invitation_id)
      if invitation.nil?
        raise "No such invitation"
      end
      if user.current_group_id != invitation.group_to_id &&
          user.current_group_id != invitation.group_from_id
        raise "Illegal request"
      end
      agree = AgreeOnInvitation.find_by(user_id: user_id, invitation_id: invitation_id)
      if !agree.nil?
        agree.destroy
        agree.save
      end
      disagree = DisagreeOnInvitation.find_by(user_id: user_id, invitation_id: invitation_id)
      if !disagree.nil?
        disagree.destroy
        disagree.save
      end
    end
    return state
  end

  def agree_on_send_invitation(user_id, invitation_id)
    user = User.find(user_id)
    if user.nil?
      raise "No such user"
    end
    agree_id = nil
    Invitation.transaction do
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
    merge_result = false
    AgreeOnInvitation.transaction do
      agree_id = agree_with_invitation(user_id, invitation_id)
      if user.current_group.users.count == invitation.agree_on_invitations.count
        invitation.agree_on_invitations.destroy_all
        merge_result = accept_invitation(invitation_id)
      end
    end
    return merge_result
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
      return !merge_group(invitation.group_from_id, invitation.group_to_id).nil?
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
    AgreeOnInvitation.transaction do
      agree = AgreeOnInvitation.new
      agree.invitation_id = invitation_id
      agree.user_id = user.id
      agree.save
    end
    return agree.id
  end

  def disagree_with_invitation(user_id, invitation_id)
    disagree = DisagreeOnInvitation.find_by(invitation_id: invitation_id, user_id: user_id)
    state = DisagreeOnInvitation.transaction do
      disagree = DisagreeOnInvitation.new
      disagree.invitation_id = invitation_id
      disagree.user_id = user_id
      disagree.save
    end
    disagree.id
  end

  def find_sender(group_id_from, group_id_to)
    result = Invitation.find_by(group_from_id: group_id_from, group_to_id: group_id_to)
    if result.nil?
      return result
    else
      result
    end
  end
end
