module RecommendHelper
  def current_user_agree?(invitation)
    !invitation.agree_users.find_by(id: current_user.id).nil?
  end
  def current_user_disagree?(invitation)
    !invitation.disagree_users.find_by(id: current_user.id).nil?
  end
  def invitation_already_send?(invitation)
    invitation.active?
  end
  def is_a_send_invitation?(info)
    !info[:send_invitation].nil?
  end
  def is_a_received_invitation?(info)
    !info[:received_invitation].nil?
  end
  def has_invitation_created?(info)
    !info[:received_invitation].nil? || !info[:send_invitation].nil?
  end
  def generate_action(info)
    if has_invitation_created?(info)
      if is_a_received_invitation(info)
        invitation = info[:received_invitation]
        if current_user_agree?(invitation)
          return "You have agreed on accepting the invitation, waiting others"
        else
          link_to("Agree on accepting invitation", agree_on_accepting_invitation_path(invitation.id), method: :post, class: "btn btn-primary")
        end
      elsif is_a_send_invitation(info)
        invitation = info[:send_invitation]
        if current_user_agree?(invitation)
          return "You have agreed on sending the invitation, waiting others"
        else
          link_to("Agree on sending invitation", agree_on_sending_invitation_path(invitation.id), method: :post, class: "btn btn-primary")
        end
      end
    else
      link_to("Invite Group", create_invitation_request_path(info[:group].id), method: :post, class: "btn btn-primary")
    end
  end

  def display_agree_on_invitation(invitation)
    agree_str = ""
    count = 1
    invitation.agree_users.each do |user|
      if count == invitation.agree_users.count
        agree_str = agree_str + user.username + " | "
      else
        agree_str = agree_str + user.username + " | "
      end
    end
    agree_str
  end
  def display_disagree_on_invitation(invitation)
    disagree_str = ""
    count = 1
    invitation.disagree_users.each do |user|
      if count == invitation.agree_users.count
        disagree_str = disagree_str + user.username + " | "
      else
        disagree_str = disagree_str + user.username + " | "
      end
    end
    disagree_str
  end


end
