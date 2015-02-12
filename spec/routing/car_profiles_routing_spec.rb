require "rails_helper"

RSpec.describe CarProfilesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/car_profiles").to route_to("car_profiles#index")
    end

    it "routes to #new" do
      expect(:get => "/car_profiles/new").to route_to("car_profiles#new")
    end

    it "routes to #show" do
      expect(:get => "/car_profiles/1").to route_to("car_profiles#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/car_profiles/1/edit").to route_to("car_profiles#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/car_profiles").to route_to("car_profiles#create")
    end

    it "routes to #update" do
      expect(:put => "/car_profiles/1").to route_to("car_profiles#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/car_profiles/1").to route_to("car_profiles#destroy", :id => "1")
    end

  end
end
