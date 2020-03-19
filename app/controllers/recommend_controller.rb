class RecommendController < ApplicationController
  before_action :logged_in_user


  include RecommendHelper
  include InvitationHelper
  include SessionsHelper
  def show
    #Login user placeholder
    user = current_user()

    recommend_groups = []
    LesseeRequest.where(group_id: @current_user.current_group).each do |request|
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
