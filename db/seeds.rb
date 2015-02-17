# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


#api_key = "uvgp3r9dfpve37bchqu4vp4g"
#user = User.create(name: 'tap', email: 'bigtap@taptech.net', password: 'foobar', password_confirmation:'foobar')
#car_profile = user.car_profiles.create(make: 'honda', model: 'civic', year: '2013')
#model_year_query = "https://api.edmunds.com/api/vehicle/v2/#{car_profile.make}/#{car_profile.model}/#{car_profile.year}?view=full&fmt=json&api_key=#{api_key}"
#model_year_response = JSON.parse(HTTParty.get(model_year_query).body)
#model_year_id = model_year_response["id"]
#car_profile.update_attributes(external_id: model_year_id)
#maintenance_query = "https://api.edmunds.com/v1/api/maintenance/actionrepository/findbymodelyearid?modelyearid=#{model_year_id}&fmt=json&api_key=#{api_key}"
#maintenance_response = JSON.parse(HTTParty.get(maintenance_query).body)
#
#maintenance_response["actionHolder"].each do |mreport|
#  car_profile.maintenance_actions.create({
#        external_id: mreport["id"], engine_code: mreport["engineCode"], transmission_code: mreport["transmissionCode"],interval_month: mreport["intervalMonth"],
#        interval_mileage: mreport["intervalMileage"],  frequency: mreport["frequency"], part_cost_per_unit: mreport["partCostPerUnit"],
#        action: mreport["action"], item: mreport["item"], item_description: mreport["itemDescription"], labor_units: mreport["laborUnits"],
#        parts_units: mreport["partsUnits"], drive_type: mreport["driveType"], model_year: mreport["modelYear"]
#                                         })
#end

def save_maintenance(user,car_profile)
  api_key = ENV['EDMUNDS_API_KEY']
  model_year_query = EdmundsApi.create_model_year_id_query(car_profile: car_profile, api_key: api_key)

  model_year_id = EdmundsApi.get_model_year_id(model_year_query: model_year_query)
  car_profile.update_attributes(external_id: model_year_id)
  maintenance_query = EdmundsApi.create_maintenance_action_query(model_year_id: model_year_id, api_key: api_key)
  maintenance_response = EdmundsApi.get_maintenance_actions(maintenance_action_query: maintenance_query)
  maintenance_response["actionHolder"].each do |mreport|
  car_profile.maintenance_actions.create({external_id: mreport["id"], engine_code: mreport["engineCode"], transmission_code: mreport["transmissionCode"],interval_month: mreport["intervalMonth"],
    interval_mileage: mreport["intervalMileage"],  frequency: mreport["frequency"], part_cost_per_unit: mreport["partCostPerUnit"],
    action: mreport["action"], item: mreport["item"], item_description: mreport["itemDescription"], labor_units: mreport["laborUnits"],
    parts_units: mreport["partsUnits"], drive_type: mreport["driveType"], model_year: mreport["modelYear"]})
  end

  engine_codes = car_profile.maintenance_actions.select(:engine_code, :id).distinct
  puts engine_codes.first.engine_code
  car_profile.update_attributes(engine_code: engine_codes.first.engine_code)
end


user = User.create(name: 'tap', email: 'bigtap@taptechnology.net', password: 'foobar', password_confirmation:'foobar')

car_profile = user.car_profiles.create(make: 'honda', model: 'civic', year: '2013', name: 'hc2013')
carmanate = CarmanateService.new(user: user, car_profile: car_profile)
puts "saving user => #{user.name}"
carmanate.save_maintenance_actions
#save_maintenance(user,car_profile)
user2 = User.create(name: 'BIG', email: 'big@tex.net', password: 'foobar', password_confirmation:'foobar')
car_profile2 = user2.car_profiles.create!(make: 'honda', model: 'accord', year: '2014', name: 'hac2014')
carmanate2 = CarmanateService.new(user: user2, car_profile: car_profile2)
carmanate2.save_maintenance_actions
#save_maintenance(user2,car_profile2)
puts "saving user => #{user2.name}"

makes_response = JSON.parse(HTTParty.get("https://api.edmunds.com/api/vehicle/v2/makes?view=basic&fmt=json&api_key=uvgp3r9dfpve37bchqu4vp4g").body)
makes_response["makes"].each{|make| make["models"].each{|model| model["years"].each{|year| CarMake.create(external_id: make["id"],
                              make_name: make["name"], make_nice_name: make["niceName"], cmodel_name: model["name"],
                              cmodel_nice_name: model["niceName"], year: year["year"]) }}}

