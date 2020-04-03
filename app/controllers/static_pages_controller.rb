#Author: Hanting Ge
class StaticPagesController < ApplicationController
  include RecommendHelper
  include InvitationHelper

  def home
    @properties = Property.all
    @cities = City.all
    @states = State.all
    @countries = Country.all
	if logged_in?
    	inv_req
	end
  end

  def property_search
    @properties = Property.all
  end

  def lessee_search
    @lessees = LesseeRequest.all
  end

  def result 
    @city_query = params[:city_name]

    @cities = City.where('lower(city_name) LIKE ?', "%#{@city_query.downcase}%")
    @city = @cities.first.id
    @properties = Property.where('city_id = ?', "#{@city}")
    #@properties = Property.find_by(city_id: @city)

    render 'show'
  end

  def lessee_result
    @city_query = params[:city_name]
    @cities = City.where('lower(city_name) LIKE ?', "%#{@city_query.downcase}%")
    @city = @cities.first.id
    @lessees = LesseeRequest.where('city_id = ?', "#{@city}")

    render 'show_lessee'
  end

  def show_lessee
    @lessee = LesseeRequest.first

    respond_to do |format|
      format.js {render layout: false}
    end
  end

  def show 
    @property = Property.first

    respond_to do |format|
      format.js {render layout: false}
    end
  end

  def login
    render "sessions/new"
  end

  def signup
    render "users/new"
  end

  def inv_req
    #Login user placeholder
    user = current_user()

    recommend_groups = []
    LesseeRequest.where(group_id: @current_user.current_group).each do |request|
      recommend_groups += find_recommend_group(request.id)
    end
    recommend_groups = recommend_groups.uniq

    @current_group = @current_user.current_group
    @group_info = []
    recommend_groups.each do |group|
      @group_info.append({:group => group,
                          :received_invitation => find_sender(group.id, current_user.current_group_id),
                          :send_invitation => find_sender(current_user.current_group_id, group.id)})
    end
    #render "show_inv_req"
  end

  def show_inv_req
    #@property = Property.first

    respond_to do |format|
      format.js {render layout: false}
    end
  end

  

end
