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
  end

  # GET /car_profiles/new
  def new
    make = params[:make]
    model = params[:model]
    year = params[:year]
    @car_profile = CarProfile.new
    get_make_model_year
    #@make_names = CarMake.select(:make_name).distinct.order(:make_name)
    #@model_names = []
    #@years = []
   # @model_names = CarMake.select(:cmodel_name).where(make_name: @car_profile.make).map{|a| [a["cmodel_name"], a["cmodel_name"]]} unless model && make
   # @years = CarMake.select(:year).where(make_name: @car_profile.make, cmodel_name: @car_profile.model) unless @car_profile.model && @car_profile.make && @car_profile.year
  end

  # GET /car_profiles/1/edit
  def edit
    @car_profile = CarProfile.find(params[:id])
    get_make_model_year
    #@make = @car_profile.make
    #@model = @car_profile.model
    #@year = @car_profile.year
    #@make_names = CarMake.select(:make_name).distinct.order(:make_name)
    #
    ##@make_names = CarMake.select(:make_name).distinct.order(:make_name).map.map{|a| [a["make_name"], a["make_name"]]}
    #@model_names = CarMake.select(:cmodel_name,:cmodel_name).distinct.where(make_name: @car_profile.make).order(:cmodel_name).map{|a| [a["cmodel_name"], a["cmodel_name"]]}
    #@years = CarMake.select(:year).where(make_name: @make, cmodel_name: @model).distinct.order(:year).map{|a| [a["year"], a["year"]]}

  end

  # POST /car_profiles
  # POST /car_profiles.json
  def create
    @car_profile =  current_user.car_profiles.new(car_profile_params)
    #@car_profile = CarProfile.new(car_profile_params)
    puts "This is a => #{@car_profile.inspect}"

      if @car_profile.save
        puts "We SAVED in create!!!!!!"
        @carmante_service = CarmanateService.new({car_profile: @car_profile, user: current_user})
        @carmante_service.delete_maintenance_actions
        @carmante_service .save_maintenance_actions

        if has_engine_code? @car_profile.engine_code
          redirect_to @car_profile, notice: 'Car profile was successfully created.'
        #format.html { redirect_to @car_profile, notice: 'Car profile was successfully created.' }
        #format.json { render :show, status: :created, location: @car_profile }
        else
          render 'edit'
        end
      else
        get_make_model_year
        render :new
        #format.html { render :new }
        #format.json { render json: @car_profile.errors, status: :unprocessable_entity }
      end

  end

  # PATCH/PUT /car_profiles/1
  # PATCH/PUT /car_profiles/1.json
  def update
      if @car_profile.update(car_profile_params)
        puts "We SAVED in update!!!!!!"
        @carmante_service  = CarmanateService.new({car_profile: @car_profile, user: current_user})
        @carmante_service.delete_maintenance_actions
        @carmante_service.save_maintenance_actions
        if has_engine_code? @car_profile.engine_code
          redirect_to @car_profile, notice: 'Car profile was successfully updated.'
          #format.html { redirect_to @car_profile, notice: 'Car profile was successfully created.' }
          #format.json { render :show, status: :created, location: @car_profile }
        else
          render 'edit'
        end
      else
        get_make_model_year
        render :edit
        #format.html { render :edit }
        #format.json { render json: @car_profile.errors, status: :unprocessable_entity }
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
