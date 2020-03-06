class InvitationController < ApplicationController
  include InvitationHelper
  def invite
    params.require(:group_to_id)
    group_to_id = params.require(:group_to_id)
    #user place holder
    # user = current_user
    user = User.find(1)
    group_from_id = user.group_id
    begin
      create_invitation(group_from_id, group_to_id)
    rescue => ex
      flash[:danger] = ex.message
    end
    render recommendation_path
  end

  def accept
    params.require(:invitation_id)
    invitation_id = params[:invitation_id]

    begin
    accept_invitation(invitation_id)
    rescue => ex
      flash[:danger] = ex.message
    end
    redirect_to mygroup_path
  end


end
