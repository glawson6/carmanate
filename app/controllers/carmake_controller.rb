class CarmakeController < ApplicationController
  def make_model_year
    @make = params[:make]
    @model = params[:model]
    @year = params[:year]
    pattern_make = @make.downcase
    pattern_model = @model.downcase
    @car_profile = CarProfile.new({make: @make, model: @model, year: @year})
    make_where = " LOWER(make_name) LIKE '%#{pattern_make}%'"
    year_where = "LOWER(make_name) LIKE '%#{pattern_make}%' and LOWER(cmodel_name) LIKE '%#{pattern_model}%'"
    puts "Car profile in CarmakeController.make_model_year #{@car_profile}"
    #@engine_codes = @car_profile.maintenance_actions.select(:engine_code).distinct
    @engine_codes = MaintenanceAction.select(:engine_code).distinct.where(car_make_id: @car_profile.car_make_id)
    @make_names = CarMake.select(:make_name).distinct.order(:make_name).map.map{|a| [a["make_name"], a["make_name"]]}
    @model_names = CarMake.select(:cmodel_name).distinct.where(make_where).order(:cmodel_name).map{|a| [a["cmodel_name"], a["cmodel_name"]]}
    #@model_names = CarMake.select(:cmodel_name).distinct.where(model_where)
    #@years = CarMake.select(:year).where(make_name: @make, cmodel_name: @model).distinct.order(:year).map{|a| [a["year"], a["year"]]}
    @years = CarMake.select(:year).where(year_where).distinct.order(:year).map{|a| [a["year"], a["year"]]}
    @model_names = {} unless @model_names

    puts "make => #{@make}, model => #{@model}, year => #{@year}"
    render 'make_model_year'
  end
end
