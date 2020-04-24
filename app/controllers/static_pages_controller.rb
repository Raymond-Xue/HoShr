#Author: Hanting Ge
class StaticPagesController < ApplicationController
  include RecommendationService
  include InvitationService

  def home
    @properties = Property.all
    @cities = City.all
    @states = State.all
    @countries = Country.all

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
    #render "show_inv_req"
  end

  def show_inv_req
    #@property = Property.first

    respond_to do |format|
      format.js {render layout: false}
    end
  end

  

end
