module GroupsHelper
  include GroupService
  # merge two group

  def matching_closed?
    group_close_matching(current_user.current_group_id)
  end

  def can_exit_group?
    can_exit_group(current_user.current_group_id)
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