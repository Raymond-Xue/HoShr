module InvitationHelper

  def create(group_from_id, group_to_id)

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
      end
    end

    if state.nil?
      Group.all
      raise "Fail to add invitation"
    end
  end

  def show_received_invitation(group_id)
    Invitation.find_by_group_to_id(group_id)
  end

  def accept_invitation(invitation_id)

    Invitation.transaction do
      invitation = Invitation.find(invitation_id)
      if invitation.nil?
        raise "Invitation not found"
      end

    end

  end

  def find_sender(group_id_from, group_id_to)
    Invitation.find_by(group_from_id: group_id_from, group_to_id: group_id_to)
  end



end
