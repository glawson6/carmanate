require 'rails_helper'

RSpec.describe "car_profiles/show", type: :view do
  before(:each) do
    @car_profile = assign(:car_profile, CarProfile.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
