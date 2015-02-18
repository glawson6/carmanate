require_relative 'car_profile'

class EdmundsApi
  def self.create_model_year_id_query(args)
    car_profile ||= args[:car_profile]
    api_key ||= args[:api_key]
    make = car_profile.make.gsub(/[ ]/, "-")
    model = car_profile.model.gsub(/[ ]/, "-")
    year = car_profile.year.to_s
    puts "create_model_year_id_query car_profile => #{car_profile}, make => #{make}, model => #{model}, year => #{year}"
    return "https://api.edmunds.com/api/vehicle/v2/#{make}/#{model}/#{year}?view=full&fmt=json&api_key=#{api_key}" if car_profile
  end

  def self.get_model_year_id(args)
    model_year_query = args[:model_year_query]
    model_year_response = JSON.parse(HTTParty.get(model_year_query).body) if model_year_query
    return model_year_response["id"] #if model_year_response
  end

  def self.create_maintenance_action_query(args)
    model_year_id = args[:model_year_id]
    api_key = args[:api_key]
    puts "api_key => #{api_key}, model_year_id => #{model_year_id}"
    return "https://api.edmunds.com/v1/api/maintenance/actionrepository/findbymodelyearid?modelyearid=#{model_year_id}&fmt=json&api_key=#{api_key}" if model_year_id
  end

  def self.get_maintenance_actions(args)
    maintenance_action_query ||= args[:maintenance_action_query]
    maintenance_action_response = JSON.parse(HTTParty.get(maintenance_action_query).body) if maintenance_action_query
    return maintenance_action_response if maintenance_action_query
  end
end