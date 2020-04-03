module GroupsHelper
  # merge two group
def merge_group(group_id_1, group_id_2)

  raise "Assert Error" unless group_id_1 != group_id_2

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
  end
end

def quit_group(user_id)
  User.transaction do
    user = User.find(user_id)
    if user.origin_group == user.current_group
      raise "Cannot exit origin group"
    end
    group = user.current_group
    user.group = user.origin_group
    if group.users.empty?
      destroy_group(group.id)
    end
    user.save
  end
end

private
def destroy_group(group_id)

  assert_group = Group.find(group_id)
  raise "Assert Error" unless !assert_group.nil?
  raise "Assert Error" unless assert_group.users.empty?

  Group.transaction do
    group = Group.find(group_id)
    if group_id.nil?
      raise "No such group"
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