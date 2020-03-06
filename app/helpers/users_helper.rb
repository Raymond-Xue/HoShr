module UsersHelper

  def leave_group
    # Todo User placeholder
    user = User.find(1)
    if user.group_id == user.origin_group_id
      raise "Invalid request"
    end
    user.group_id != user.origin_group_id
    user.group_id = user.origin_group_id
    user.save
  end
end

