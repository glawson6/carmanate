require 'rails_helper'

describe CarMake do

  let(:car_make) { FactoryGirl.create(:car_make) }

  subject { car_make }

  it { should respond_to(:model_year_id) }
  it { should respond_to(:make_name) }
  it { should respond_to(:make_nice_name) }
  it { should respond_to(:cmodel_name) }
  it { should respond_to(:cmodel_nice_name) }
  it { should respond_to(:year) }
end
