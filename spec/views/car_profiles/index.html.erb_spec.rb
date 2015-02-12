require 'rails_helper'

RSpec.describe "car_profiles/index", type: :view do
  before(:each) do
    assign(:car_profiles, [
      CarProfile.create!(),
      CarProfile.create!()
    ])
  end

  it "renders a list of car_profiles" do
    render
  end
end
