class LesseeRequestsController < ApplicationController
  before_action :set_lessee_request, only: [:show, :edit, :update, :destroy]

  # GET /lessee_requests
  # GET /lessee_requests.json
  def index
    @lessee_requests = LesseeRequest.all
  end

  # GET /lessee_requests/1
  # GET /lessee_requests/1.json
  def show
  end

  # GET /lessee_requests/new
  def new
    @lessee_request = LesseeRequest.new
  end

  # GET /lessee_requests/1/edit
  def edit
  end

  # POST /lessee_requests
  # POST /lessee_requests.json
  def create
    @lessee_request = LesseeRequest.new(lessee_request_params)
    @lessee_request.group = current_user.current_group
    @lessee_request.country_id = Country.find_by(:country_name => lessee_request_params[:country]).id
    @lessee_request.state_id = State.find_by(:state_name => lessee_request_params[:state], :country_id => @lessee_request.country_id).id
    @lessee_request.city_id = City.find_by(:city_name => lessee_request_params[:city], :state_id => @lessee_request.state_id).id
    
    respond_to do |format|
      if @lessee_request.save
        format.html { redirect_to my_lessee_path}
        format.json { render :show, status: :created, location: @lessee_request }
      else
        format.html { render :new }
        format.json { render json: @lessee_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lessee_requests/1
  # PATCH/PUT /lessee_requests/1.json
  def update
    respond_to do |format|
    @lessee_request.group = current_user.current_group
    if City.find_by(:city_name => lessee_request_params[:city])
		@lessee_request.country_id = Country.find_by(:country_name => lessee_request_params[:country]).id
		@lessee_request.state_id = State.find_by(:state_name => lessee_request_params[:state], :country_id => @lessee_request.country_id).id
		@lessee_request.city_id = City.find_by(:city_name => lessee_request_params[:city], :state_id => @lessee_request.state_id).id
	end
      if @lessee_request.update(lessee_request_params)
        format.html { redirect_to my_lessee_path}
        format.json { render :show, status: :ok, location: @lessee_request }
      else
        format.html { render :edit }
        format.json { render json: @lessee_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lessee_requests/1
  # DELETE /lessee_requests/1.json
  def destroy
    @lessee_request.destroy
    respond_to do |format|
      format.html { redirect_to lessee_requests_url}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lessee_request
      @lessee_request = LesseeRequest.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def lessee_request_params
      params.require(:lessee_request).permit(:country, :state, :city, :latitude, :longitude, :radius, :city_id, :state_id, :country_id, :group_id, :earliest_movein_date, :latest_movein_date, :min_duration, :max_duration, :duration_unit, :max_rent, :max_rent_unit, :max_rent_currency, :max_n_roommates, :max_n_housemates, :private_bath, :balcony, :smoke, :roommate_gender)
    end
end
