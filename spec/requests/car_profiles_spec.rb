require 'rails_helper'

RSpec.describe "CarProfiles", type: :request do
  describe "GET /car_profiles" do
    it "works! (now write some real specs)" do
      get car_profiles_path
      expect(response).to have_http_status(200)
    end
  end
end
