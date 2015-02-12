json.array!(@car_profiles) do |car_profile|
  json.extract! car_profile, :id
  json.url car_profile_url(car_profile, format: :json)
end
