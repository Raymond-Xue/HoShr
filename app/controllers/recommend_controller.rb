class RecommendController < ApplicationController

  include RecommendHelper
  include InvitationHelper
  def show
    #Login user placeholder
    current_user = User.find(1)

    recommend_groups = []
    LesseeRequest.where(group_id: current_user.group_id).each do |request|
      recommend_groups += find_recommend_group(request.id)
    end
    recommend_groups = recommend_groups.uniq

    @group_info = []
    recommend_groups.each do |group|
      @group_info.append({:group => group,
                          :invitation => find_sender(group.id, current_user.group_id)})
    end
    render 'recommendation'

  end

  def new_merge_request

  end

end
