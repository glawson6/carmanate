require 'rails_helper'

RSpec.describe "car_profiles/edit", type: :view do
  before(:each) do
    @car_profile = assign(:car_profile, CarProfile.create!())
  end

  it "renders the edit car_profile form" do
    render

    assert_select "form[action=?][method=?]", car_profile_path(@car_profile), "post" do
    end
  end
end
