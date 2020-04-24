class GroupsController < ApplicationController
  include GroupService
  #before_action :set_group, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:my_group, :my_lessee, :index, :new, :create, :destroy]

  # GET /groups
  # GET /groups.json
  def index
    @groups = Group.all
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
  end

  # GET /groups/new
  def new
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new(group_params)

    respond_to do |format|
      if @group.save
        format.html { redirect_to @group, notice: 'Group was successfully created.' }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url, notice: 'Group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def submit
    LesseeRequest.create(group_id: current_user.current_group_id, id: params[:lessee_request_id])
    flash[:success] = 'Request Submit Success!'

    redirect_to my_lessee_path
  end

  def cancel
    LesseeRequest.where(group_id: current_user.current_group_id).first.destroy
    flash[:success] = 'Request Submit Success!'

    redirect_to my_lessee_path
  end

  def quit
    begin
      quit_group(current_user.id)
    rescue => ex
      flash[:danger] = ex.message
    end
    redirect_to my_group_path
  end


  def close_matching
    begin
      GroupService::close_matching(current_user.current_group_id)
    rescue => ex
      flash[:danger] = ex.message
    end
    redirect_to my_group_path
  end

  def open_matching
    begin
      GroupService::open_matching(current_user.current_group_id)
    rescue => ex
      flash[:danger] = ex.message
    end
    redirect_to my_group_path
  end

  def my_lessee
    @user = current_user
    @group = Group.find_by(:id => @user.current_group_id)
    @lessee_requests = LesseeRequest.where(:group_id => @group.id)
  end

  def my_group
    @user = current_user
    @group = Group.find_by(:id => @user.current_group_id)
    @members = User.where(:current_group_id => @group.id)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_group
    @group = Group.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def group_params
    params.require(:group).permit(:group_id, :n_lessees)
  end
end
