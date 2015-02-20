class CarProfilesController < ApplicationController
  before_action :set_car_profile, only: [:show, :edit, :update, :destroy]
  before_action :signed_in_user

  include CarProfilesHelper
  # GET /car_profiles
  # GET /car_profiles.json
  def index
    @car_profiles = current_user.car_profiles.all
  end

  # GET /car_profiles/1
  # GET /car_profiles/1.json
  def show
    @car_profile = current_user.car_profiles.find(params[:id])
    @maintenance_actions = MaintenanceAction.where(car_make_id: @car_profile.car_make_id, engine_code: @car_profile.engine_code).order(:interval_mileage).paginate(:page => params[:page], :per_page => 7)
    puts @maintenance_actions.count
    if @maintenance_actions.count > 0
      render 'show'
    else
      render 'edit'
    end
  end

  # GET /car_profiles/new
  def new
    make = params[:make]
    model = params[:model]
    year = params[:year]
    @car_profile = CarProfile.new
    get_make_model_year

  end

  # GET /car_profiles/1/edit
  def edit
    @car_profile = CarProfile.find(params[:id])
    get_make_model_year
  end

  # POST /car_profiles
  # POST /car_profiles.json
  def create
    @car_profile =  current_user.car_profiles.new(car_profile_params)
    puts "This is a => #{@car_profile.inspect}"

      if @car_profile.save
        puts "We SAVED in create!!!!!!"
        @carmante_service = CarmanateService.new({car_profile: @car_profile, user: current_user})
        @carmante_service.delete_maintenance_actions

          @carmante_service.save_maintenance_actions if (@car_profile.make && @car_profile.model && @car_profile.year)

        if has_engine_code? @car_profile.engine_code
          redirect_to @car_profile, notice: 'Car profile was successfully created.'
        else
          render 'edit'
        end
      else
        get_make_model_year
        render :new
      end

  end

  # PATCH/PUT /car_profiles/1
  # PATCH/PUT /car_profiles/1.json
  def update
      if @car_profile.update(car_profile_params)
        @carmante_service  = CarmanateService.new({car_profile: @car_profile, user: current_user})
        @carmante_service.delete_maintenance_actions
        @carmante_service.save_maintenance_actions if (@car_profile.make && @car_profile.model && @car_profile.year)
        if has_engine_code? @car_profile.engine_code
          redirect_to @car_profile, notice: 'Car profile was successfully updated.'
        else
          render 'edit'
        end
      else
        get_make_model_year
        render :edit
      end
  end

  # DELETE /car_profiles/1
  # DELETE /car_profiles/1.json
  def destroy
    @car_profile.destroy
    redirect_to user_path current_user, notice: 'Car profile was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_car_profile
      @car_profile = CarProfile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def car_profile_params
      params.require(:car_profile).permit(:make, :model, :year, :name, :engine_code)
    end
end
