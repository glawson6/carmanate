class CarProfilesController < ApplicationController
  before_action :set_car_profile, only: [:show, :edit, :update, :destroy]
  before_action :signed_in_user

  # GET /car_profiles
  # GET /car_profiles.json
  def index
    @car_profiles = CarProfile.all
  end

  # GET /car_profiles/1
  # GET /car_profiles/1.json
  def show
    @car_profile = current_user.car_profiles.find(params[:id])
    @maintenance_actions = @car_profile.maintenance_actions.where(engine_code: @car_profile.engine_code).order(:interval_mileage)
    puts @maintenance_actions.count
  end

  # GET /car_profiles/new
  def new
    @car_profile = CarProfile.new
  end

  # GET /car_profiles/1/edit
  def edit
    @car_profile = CarProfile.find(params[:id])
  end

  # POST /car_profiles
  # POST /car_profiles.json
  def create
    @car_profile = CarProfile.new(car_profile_params)

    respond_to do |format|
      if @car_profile.save
        format.html { redirect_to @car_profile, notice: 'Car profile was successfully created.' }
        format.json { render :show, status: :created, location: @car_profile }
      else
        format.html { render :new }
        format.json { render json: @car_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /car_profiles/1
  # PATCH/PUT /car_profiles/1.json
  def update
    respond_to do |format|
      if @car_profile.update(car_profile_params)
        format.html { redirect_to @car_profile, notice: 'Car profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @car_profile }
      else
        format.html { render :edit }
        format.json { render json: @car_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /car_profiles/1
  # DELETE /car_profiles/1.json
  def destroy
    @car_profile.destroy
    respond_to do |format|
      format.html { redirect_to car_profiles_url, notice: 'Car profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_car_profile
      @car_profile = CarProfile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def car_profile_params
      params[:car_profile]
    end
end
