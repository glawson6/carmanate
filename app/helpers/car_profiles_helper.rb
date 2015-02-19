module CarProfilesHelper

  def has_engine_code?(engine_code)

    @engine_codes = MaintenanceAction.select(:engine_code).distinct.where(car_make_id: @car_profile.car_make_id)
    get_make_model_year
    has_engine_code = false
    @engine_codes.find{|ecode| engine_code == ecode[:engine_code]  }
  end

  def get_make_model_year

    @make = @car_profile.make
    @model = @car_profile.model
    @year = @car_profile.year
    puts "In get_make_model_year car_profile => #{@car_profile.to_s}"
    @make_names = CarMake.select(:make_name).distinct.order(:make_name)
    #@make_names = CarMake.select(:make_name).distinct.order(:make_name).map.map{|a| [a["make_name"], a["make_name"]]}
    @model_names = CarMake.select(:cmodel_name,:cmodel_name).distinct.where(make_name: @car_profile.make).order(:cmodel_name).map{|a| [a["cmodel_name"], a["cmodel_name"]]}
    @years = CarMake.select(:year).where(make_name: @make, cmodel_name: @model).distinct.order(:year).map{|a| [a["year"], a["year"]]}
  end
end
