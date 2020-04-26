
module GroupService
  # merge two group
  def merge_group(group_id_1, group_id_2)

    raise "Assert Error" unless group_id_1 != group_id_2

    group_id = nil
    Group.transaction do
      group_1 = Group.find(group_id_1)
      group_2 = Group.find(group_id_2)

      if group_1.nil? || group_2.nil?
        raise "Group not find"
      end

      new_group = Group.new

      group_1.users.each { |user|
        user.current_group = new_group
        user.save
      }
      group_2.users.each{ |user|
        user.current_group = new_group
        user.save
      }
      destroy_group(group_1.id)
      destroy_group(group_2.id)
      new_group.save
      group_id = new_group.id
    end
    return group_id
  end

  def quit_group(user_id)
    User.transaction do
      user = User.find(user_id)
      if user.origin_group == user.current_group
        raise "Cannot exit group"
      end
      left_group = user.current_group
      left_group.send_invitation.all.each do  |invitation|
        AgreeOnInvitation.where(invitation_id: invitation.id).destroy_all
        DisagreeOnInvitation.where(invitation_id: invitation.id).destroy_all
      end
      left_group.received_invitation.all.each do  |invitation|
        AgreeOnInvitation.where(invitation_id: invitation.id).destroy_all
        DisagreeOnInvitation.where(invitation_id: invitation.id).destroy_all
      end
      AgreeOnInvitation.where(invitation_id: left_group.id).destroy_all
      DisagreeOnInvitation.where(invitation_id: left_group.id).destroy_all
      Invitation.where(group_to_id: left_group.id).destroy_all
      Invitation.where(group_from_id: left_group.id).destroy_all
      user.current_group = user.origin_group
      user.current_group.lessee_request.all.each do |request|
        request.active = true
        request.save
      end
      user.save
      if left_group.users.empty?
        destroy_group(left_group.id)
      end
    end
  end

  def group_close_matching(group_id)
    Group.transaction do
      group = Group.find(group_id)
      group.active_for_matching = false
      group.lessee_request.all.each do |request|
        request.active = false
        request.save
      end
      group.save
    end
  end

  def group_open_matching(group_id)
    Group.transaction do
      group = Group.find(group_id)
      group.active_for_matching = true
      group.lessee_request.all.each do |request|
        request.active = true
        request.save
      end
      group.save
    end
  end

  def matching_closed?(group_id)
    !Group.find(group_id).active_for_matching
  end



  private
  def destroy_group(group_id)

    assert_group = Group.find(group_id)
    raise "Assert Error" unless !assert_group.nil?
    raise "Assert Error" unless assert_group.users.empty?

    Group.transaction do
      group = Group.find(group_id)
      if group.nil?
        raise "No such group"
      end
      group.received_invitation.all.each do |invitation|
        invitation.agree_on_invitations.destroy_all
        invitation.disagree_on_invitations.destroy_all
        invitation.save
      end
      group.send_invitation.all.each do |invitation|
        invitation.agree_on_invitations.destroy_all
        invitation.disagree_on_invitations.destroy_all
        invitation.save
      end
      group.received_invitation.destroy_all
      group.send_invitation.destroy_all
      if group.original_user.nil?
        group.lessee_request.destroy_all
        group.destroy
      else
        group.lessee_request.each { |record|
          record.active = false
          record.save
        }
      end
    end
  end


end
