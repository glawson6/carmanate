require_relative 'edmunds_api'
require_relative 'maintenance_action'
require_relative 'user'

class CarmanateService

  def initialize(args)
    @api_key = ENV['EDMUNDS_API_KEY']
    @user = args[:user]
    name = args[:name]
    #@car_profile = @user.car_profiles.where(name: name)
    @car_profile = args[:car_profile]
  end

  def save_maintenance_actions
    model_year_query = EdmundsApi.create_model_year_id_query(car_profile: @car_profile, api_key: @api_key)
    puts "model_year_query => #{model_year_query}"
    model_year_id = EdmundsApi.get_model_year_id(model_year_query: model_year_query)
    @car_profile.update_attributes(external_id: model_year_id)
    maintenance_query = EdmundsApi.create_maintenance_action_query(model_year_id: model_year_id, api_key: @api_key)
    puts "maintenance_query => #{maintenance_query}"
    maintenance_response = EdmundsApi.get_maintenance_actions(maintenance_action_query: maintenance_query)
    maintenance_response["actionHolder"].each do |mreport|
      @car_profile.maintenance_actions.create({
        external_id: mreport["id"], engine_code: mreport["engineCode"], transmission_code: mreport["transmissionCode"],interval_month: mreport["intervalMonth"],
        interval_mileage: mreport["intervalMileage"],  frequency: mreport["frequency"], part_cost_per_unit: mreport["partCostPerUnit"],
        action: mreport["action"], item: mreport["item"], item_description: mreport["itemDescription"], labor_units: mreport["laborUnits"],
        parts_units: mreport["partsUnits"], drive_type: mreport["driveType"], model_year: mreport["modelYear"]
      })
    end
  end

  def get_engine_codes
    @car_profile.maintenance_actions.select(:engine_code).distinct
  end

  def get_maintenance_actions(args)
    engine_code = args[:engine_code]
    save_maintenance_actions unless @car_profile.maintenance_actions.exist?
    maintenance_actions =  @car_profile.maintenance_actions.where(engine_code: engine_code)
  end

  def get_car_profiles
    @user.car_profiles if @user
  end

  def delete_maintenance_actions
    MaintenanceAction.where(car_profile_id: @car_profile.id).destroy_all
  end
end