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
  # hard sql to get list of requests
  # soft rate the requests
  # rank request by the rating
  # get group from the ranked request
  def find_recommend_group(request_id)
    group_request = LesseeRequest.find(request_id)
    if group_request.nil?
      raise "LesseeRequest not found."
    end
    # hard sql to get list of request
    request_list = recommend_request_sql_query(group_request)
    # sort the request by soft rating
    request_list.sort_by do |other_request|
      soft_rating(group_request, other_request)
    end
    # extract the group from the requests
    groups = extract_group_from_requests(request_list)
  end

  def extract_new_recommend_group(group_id, groups)
    result = []
    groups.each do |group|
      if group.received_invitation.find(:sender => group_id).nil? &&
          group.send_invitation.find(:receiver => group_id).nil?
        result.append(group)
      end
    end
    result
  end

  private

  # Return the recommended requests
  def recommend_request_sql_query(group_request)
    LesseeRequest.where("group_id != #{group_request.group_id} and active != false")
  end

  # Rate two requests
  def soft_rating(request_1, request_2)
    return 1
  end

  # Extract groups from a list of ordered requests. Return the list of group
  # containing the unique group with the same order of ordered requests
  def extract_group_from_requests(ordered_requests, group_num = 10)
    require 'set'
    group_set = Set[]
    group_list = []

    ordered_requests.each do |request|
      if !group_set.include?(request.group_id) &&
          group_list.length < group_num
        group_list.push(request.group)
        group_set.add(request.group_id)
      end
    end
    return group_list
  end

end
