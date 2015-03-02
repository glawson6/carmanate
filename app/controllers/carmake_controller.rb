class CarmakeController < ApplicationController
  def make_model_year
    @make = params[:make]
    @model = params[:model]
    @year = params[:year]
    @engine_code = params[:engine_code]
    pattern_make = @make.downcase
    pattern_model = @model.downcase if @model

    make_where = " LOWER(make_name) LIKE '%#{pattern_make}%'"
    year_where = "LOWER(make_name) LIKE '%#{pattern_make}%' and LOWER(cmodel_name) LIKE '%#{pattern_model}%'" if @model

    @make_names = CarMake.select(:make_name).distinct.order(:make_name).map{|a| a["make_name"]}
    @model_names = CarMake.select(:cmodel_name).distinct.where(make_where).order(:cmodel_name).map{|a| a["cmodel_name"]}
    @years = CarMake.select(:year).where(year_where).distinct.order(:year).map{|a| a["year"]} if @model

    if (@make && @model && @year)
      @car_make = CarMake.where({make_name: @make, cmodel_name: @model, year: @year}).first
      puts "Car make in CarmakeController #{@car_make}"
      @car_profile = CarProfile.find_by({make: @car_make.make_name, model: @car_make.cmodel_name, year: @car_make.year,
                                     car_make_id: @car_make.id}) if @car_make
      if !@car_profile
        @car_profile = CarProfile.create({make: @car_make.make_name, model: @car_make.cmodel_name, year: @car_make.year,
                                          car_make_id: @car_make.id})
        @carmante_service = CarmanateService.new({car_profile: @car_profile, user: current_user})
        @carmante_service.delete_maintenance_actions
        @carmante_service.save_maintenance_actions if (@car_profile.make && @car_profile.model && @car_profile.year)
        @engine_codes = MaintenanceAction.select(:engine_code).distinct.where(car_make_id: @car_make.id).map{|a| a["engine_code"]}
        puts "@engine_codes => #{@engine_codes}"
      end

    end

    puts "Car profile in CarmakeController.make_model_year #{@car_profile}"
    #@engine_codes = MaintenanceAction.select(:engine_code).distinct.where(car_make_id: @car_profile.car_make_id)
    #@make_names = CarMake.select(:make_name).distinct.order(:make_name).map{|a| [a["make_name"], a["make_name"]]}
    #@model_names = CarMake.select(:cmodel_name).distinct.where(make_where).order(:cmodel_name).map{|a| [a["cmodel_name"], a["cmodel_name"]]}
    #@years = CarMake.select(:year).where(year_where).distinct.order(:year).map{|a| [a["year"], a["year"]]}


    puts "make => #{@make}, model => #{@model}, year => #{@year}"
    render json: {make_names: @make_names, make: @make, model: @model, year: @year, model_names: @model_names,
                  years: @years, engine_code: @engine_code, engine_codes: @engine_codes}
  end
end
