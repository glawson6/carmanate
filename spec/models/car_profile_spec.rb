require 'rails_helper'

describe CarProfile do

  let(:user) { FactoryGirl.create(:user) }
  let(:car_profile) { FactoryGirl.create(:car_profile, user: user) }

  subject { car_profile }

  it { should respond_to(:model_year_id) }
  it { should respond_to(:make) }
  it { should respond_to(:model) }
  it { should respond_to(:year) }
  it { should respond_to(:engine_code) }
  it { should respond_to(:name) }
  it { should respond_to(:car_make_id) }

  it { should be_valid }

  describe 'validations' do
    describe 'name' do
      context 'not present' do
        before { car_profile.name = nil }
        it { should_not be_valid }
      end

      context 'too long' do
        before { car_profile.name = 'a' * 255 }
        it { should_not be_valid }
      end

      context 'not unique' do
        before do
          # With a user defined near the top
          car_profile_with_same_name = car_profile.dup
          car_profile_with_same_name.save

          # Original user is not valid
          it { should_not be_valid }
        end
      end
    end
  end
end