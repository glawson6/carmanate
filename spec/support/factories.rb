FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "Name Number #{n}"} # first user's name will be Name Number 1
    email { Faker::Internet.email }
    password "foobar"
    password_confirmation "foobar"

    factory :admin, parent: :user do
      email "rgpass@gmail.com"
      admin true
    end
  end

  factory :car_profile do
    make 'honda'
    model 'accord'
    year 2001
    name 'hac2001'
    engine_code '6VNAG3.0'
    user
  end

  factory :item do
    sequence(:name) { |n| "Item Number #{n}" }
    rating (1..5).to_a.sample
    price (5..30).to_a.sample
    description { Faker::Lorem.sentence(3) }
    image_file "random_thing.png"
    user
  end
end

# FactoryGirl.create(:item)  # this will automagically create a user as well
# # can override which user by doing something like:
# let(:user) { FactoryGirl.create(:user) }
# let(:item) { FactoryGirl.create(:item, user_id: user.id) }