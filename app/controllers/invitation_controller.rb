class InvitationController < ApplicationController
  include SessionsHelper
  include InvitationService

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

  def send_invitation_request
    params.require(:group_to_id)
    group_to_id = params[:group_to_id]
    user = current_user
    group_from_id = user.current_group_id
    begin
      create_invitation_request(user.id, group_from_id, group_to_id)
    rescue => ex
      flash[:danger] = ex.message
    end
    redirect_to recommendation_path
  end

  def agree_on_send_invitation_request
    params.require(:invitation_id)
    begin
      agree_on_send_invitation(current_user.id, params[:invitation_id])
    rescue => ex
      flash[:danger] = ex.message
    end
    redirect_to recommendation_path
  end

  def agree_on_accept_invitation_request
    params.require(:invitation_id)
    merge = false
    begin
      merge = agree_on_accept_invitation(current_user.id, params[:invitation_id])
    rescue => ex
      flash[:danger] = ex.message
    end
    if merge
      redirect_to my_group_path
    else
      redirect_to recommendation_path
    end
  end

  def disagree_on_send_invitation_request
    params.require(:invitation_id)
    begin
      disagree_on_send_invitation(current_user.id, params[:invitation_id])
    rescue => ex
      flash[:danger] = ex.message
    end
    redirect_to recommendation_path
  end
  def disagree_on_accept_invitation_request
    params.require(:invitation_id)
    begin
      disagree_on_accept_invitation(current_user.id, params[:invitation_id])
    rescue => ex
      flash[:danger] = ex.message
    end
    redirect_to recommendation_path
  end
  def withdraw_decision
    params.require(:invitation_id)
    begin
      destroy_agree_disagree(current_user.id, params[:invitation_id])
    rescue => ex
      flash[:danger] = ex.message
    end
    redirect_to recommendation_path
  end

  def find_invitations
    begin
      @received_invitations =
          find_received_invitation_of_group(current_user.current_group_id)
      @sent_invitations =
          find_send_invitation_of_group(current_user.current_group_id)
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
