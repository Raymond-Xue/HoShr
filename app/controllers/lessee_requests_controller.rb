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

    respond_to do |format|
      if @lessee_request.save
        format.html { redirect_to @lessee_request, notice: 'Lessee request was successfully created.' }
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
      if @lessee_request.update(lessee_request_params)
        format.html { redirect_to @lessee_request, notice: 'Lessee request was successfully updated.' }
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
      format.html { redirect_to lessee_requests_url, notice: 'Lessee request was successfully destroyed.' }
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
      params.require(:lessee_request).permit(:latitude, :longitude, :radius, :city_id, :state_id, :country_id, :lessee_id, :earliest_movein_date, :latest_movein_date, :min_duration, :max_duration, :duration_unit, :max_rent, :max_rent_unit, :max_rent_currency, :max_n_roommates, :max_n_housemates, :private_bath, :balcony, :smoke, :roommate_gender)
    end
end
