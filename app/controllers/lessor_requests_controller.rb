class LessorRequestsController < ApplicationController
  #before_action :set_lessor_request, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:index, :new, :create, :destroy]

  # GET /lessor_requests
  # GET /lessor_requests.json
  def index
    @lessor_requests = LessorRequest.all
  end

  def lessor_recommend
	@user = current_user
	@lessee_requests = LesseeRequest.where(:group_id => @user.current_group_id)
	cid = []
	@lessee_requests.each do |l|
		cid.append(l.city_id)
	end
    @lessor_requests = LessorRequest.where(:property_id => Property.where(:city_id => cid).ids)

  end

  # GET /lessor_requests/1
  # GET /lessor_requests/1.json
  def show
    @lessor_request = LessorRequest.find_by(:id => params[:id])	
  end

  # GET /lessor_requests/new
  def new
    @lessor_request = LessorRequest.new
    @property_id = params[:property_id]
  end

  # GET /lessor_requests/1/edit
  def edit
  end

  # POST /lessor_requests
  # POST /lessor_requests.json
  def create
    @lessor_request = LessorRequest.new(lessor_request_params)
    @lessor_request.property_id = params[:property_id]

    respond_to do |format|
      if @lessor_request.save
        format.html { redirect_to my_lessor_path, notice: 'Lessor request was successfully created.' }
        format.json { render :show, status: :created, location: @lessor_request }
      else
        format.html { render :new }
        format.json { render json: @lessor_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lessor_requests/1
  # PATCH/PUT /lessor_requests/1.json
  def update
    respond_to do |format|
      if @lessor_request.update(lessor_request_params)
        format.html { redirect_to @lessor_request, notice: 'Lessor request was successfully updated.' }
        format.json { render :show, status: :ok, location: @lessor_request }
      else
        format.html { render :edit }
        format.json { render json: @lessor_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lessor_requests/1
  # DELETE /lessor_requests/1.json
  def destroy
    @lessor_request = LessorRequest.find_by(:id => params[:id])
    @lessor_request.destroy
    respond_to do |format|
      format.html { redirect_to my_lessor_url, notice: 'Lessor request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lessor_request
      @lessor_request = LessorRequest.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def lessor_request_params
      params.require(:lessor_request).permit(:earliest_movein_date, :min_duration, :total_rent, :total_rent_currency)
    end
end
