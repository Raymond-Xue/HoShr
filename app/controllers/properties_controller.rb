class PropertiesController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :destroy]
  # before_action :set_property, only: [:show, :edit, :update, :destroy]


  # GET /properties
  # GET /properties.json
  def index
    if current_user
        @properties = Property.all
    else
      redirect_to "/login"
    end
  end

  # GET /properties/1
  # GET /properties/1.json
  def show
  	@property = Property.find_by(:id => params[:id])	
  end

  # GET /properties/new
  def new
    @property = Property.new
  end

  # GET /properties/1/edit
  def edit
    @property = Property.find_by(:id => params[:id])
  end

  # GET /properties/1/photo
  def photo
    @property = Property.find_by(:id => params[:id])
  end

  # POST /properties
  # POST /properties.json
  def create
    @property = Property.new(property_params)
    @property.owner_id = current_user.id
    @property.country_id = Country.find_by(country_name: params[:property][:country]).id
    @property.state_id = State.find_by(country_id: @property.country_id, state_name: params[:property][:state]).id
    @property.city_id = City.find_by(state_id: @property.state_id, city_name: params[:property][:city]).id
    @property = address_standardilization(@property)
    
    respond_to do |format|
      if @property.save
        format.html { redirect_to @property, notice: 'Property was successfully created.' }
        format.json { render :show, status: :created, location: @property }
      else
        format.html { render :new }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end
  end

  def my_lessor
	@user = current_user
    @properties = Property.where(:owner_id => current_user.id)
	@lessor_requests = nil
	if @properties.count > 0
		@lessor_requests = LessorRequest.where(:property_id => @properties.first.id)
	end
	if @properties.count > 1
		for i in 1..(@properties.count - 1) do
    		@lessor_requests = @lessor_requests + LessorRequest.where(:property_id => @properties[i].id)
		end
	end
  end

  # PATCH/PUT /properties/1
  # PATCH/PUT /properties/1.json
  def update
    @property = Property.find_by(:id => params[:id])
    if Country.find_by(country_name: params[:property][:country])
      @property.owner_id = current_user.id
      @property.country_id = Country.find_by(country_name: params[:property][:country]).id
      @property.state_id = State.find_by(country_id: @property.country_id, state_name: params[:property][:state]).id
      @property.city_id = City.find_by(state_id: @property.state_id, city_name: params[:property][:city]).id
      @property = address_standardilization(@property)
    end
    if !params[:avatar].nil?
      @property.avatar.attach(params[:avatar])
    end
    respond_to do |format|
      if @property.update(property_params)
        format.html { redirect_to @property, notice: 'Property was successfully updated.' }
        format.json { render :show, status: :ok, location: @property }
      else
        format.html { render :edit }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /properties/1
  # DELETE /properties/1.json
  def destroy
    @property = Property.find_by(:id => params[:id])
    @property.destroy
    respond_to do |format|
      format.html { redirect_to my_property_url, notice: 'Property was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def post 
	  LessorRequest.create(property_id: @property.id)
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_property
      @property = Property.find(params[:id])
    end

    def address_standardilization(property)
      Geokit::Geocoders::GoogleGeocoder.api_key = 'AIzaSyA7ClwnGU9QTuNhY3DuVqM5K5YbWA7zJsI'
      a=Geokit::Geocoders::GoogleGeocoder.geocode(property.street_address + ' ' + property.city.city_name + ' ' + property.city.state.state_name)
      property.street_address = a.street_number + ' ' + a.street_name
      property.latitude = a.lat.to_f
      property.longitude = a.lng.to_f
      return property
    end


    # Only allow a list of trusted parameters through.
    def property_params
      params.require(:property).permit(:latitude, :longitude, :street_address, :city_id, :state_id, :country_id, :zipcode, :owner_id, :n_bedrooms, :n_bathroom, :hasKitchen, :hasSmokeDetector, :hasAirConditioning, :type_id, avatar: [])
    end
end
