require 'rails_helper'

RSpec.describe "car_profiles/new", type: :view do
  before(:each) do
    assign(:car_profile, CarProfile.new())
  end

  it "renders new car_profile form" do
    render

    assert_select "form[action=?][method=?]", car_profiles_path, "post" do
    end
  end
end
