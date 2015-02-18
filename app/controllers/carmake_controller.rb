class CarmakeController < ApplicationController
  def make_model_year
    @make = params[:make]
    @model = params[:model]
    @year = params[:year]
    @car_profile = CarProfile.new({make: @make, model: @model, year: @year})
    puts "make => #{@make}"
    puts @car_profile
    @engine_codes = @car_profile.maintenance_actions.select(:engine_code).distinct
    @make_names = CarMake.select(:make_name).distinct.order(:make_name).map.map{|a| [a["make_name"], a["make_name"]]}
    @model_names = CarMake.select(:cmodel_name).distinct.where(make_name: @car_profile.make).order(:cmodel_name).map{|a| [a["cmodel_name"], a["cmodel_name"]]} if @make
    @years = CarMake.select(:year).where(make_name: @make, cmodel_name: @model).distinct.order(:year).map{|a| [a["year"], a["year"]]} unless @model && @make && @year
    render 'make_model_year'
  end
end
