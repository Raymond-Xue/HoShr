class InvitationController < ApplicationController
  include InvitationHelper
  include SessionsHelper
  def create
    params.require(:group_to_id)
    group_to_id = params.require(:group_to_id)
    user = current_user
    group_from_id = user.current_group_id
    begin
      create_invitation(group_from_id, group_to_id)
    rescue => ex
      flash[:danger] = ex.message
    end
    redirect_to recommendation_path
  end

  def accept
    params.require(:invitation_id)
    invitation_id = params[:invitation_id]

    begin
      accept_invitation(invitation_id)
    rescue => ex
      flash[:danger] = ex.message
    end
    redirect_to recommendation_path
  end
end
