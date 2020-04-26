module UserService

  def create_new_user(params)
    @user = User.new(params)
    default_group = Group.new
    @user.current_group = default_group
    @user.origin_group = default_group
    return @user.save
  end

  def can_exit_group(user_id)
    user = User.find(user_id)
    user.current_group_id != user.origin_group_id
  end
end
