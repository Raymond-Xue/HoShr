module GroupsHelper
  def merge_group(group_id_1, group_id_2)

    assert group_id_1 != group_id_2

    Group.transaction do
      group_1 = Group.find(group_id_1)
      group_2 = Group.find(group_id_2)

      if group_1.nil? || group_2.nil?
        raise "Group not find"
      end

      new_group = Group.new

      group_1.users.each { |user|
        user.group = new_group
        if user.origin_group_id != user.group_id
          user.group.destroy
        end
        user.save
      }
      group_2.users.each{ |user|
        user.group = new_group
        if user.origin_group_id != user.group_id
          user.group.destroy
        end
        user.save
      }
      new_group.save
    end
  end

  def quit_group(user_id, group_id)
    User.transaction do
      user = User.find(user_id)
      if user.origin_group_id == group_id
        raise "Cannot exit origin group"
      end
      group = Group.find(group_id)
      if group.nil? || user.group_id != group_id
        raise "Invalid request"
      end
      user.group = user.origin_group
      if group.users.size == 0
        group.destroy
      end
      user.save
    end
  end

end

