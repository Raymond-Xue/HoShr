class RecommendController < ApplicationController
  before_action :logged_in_user

  include RecommendationService
  include InvitationService
  include SessionsHelper
  
  def show
    #Login user placeholder
    user = current_user

    recommend_groups = find_recommendation(current_user.current_group_id)

    @current_group = @current_user.current_group
    @group_info = []
    recommend_groups.keys.each do |group_id|
      @group_info.append({:group => Group.find(group_id),
                          :received_invitation => find_sender(group_id, current_user.current_group_id),
                          :send_invitation => find_sender(current_user.current_group_id, group_id),
                          :matched_requests => recommend_groups[group_id]})
    end
    render 'recommendation'

  end


end
