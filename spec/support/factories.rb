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
    year 2009
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

  factory :car_make do
    sequence(:model_year_id) {|n| n}
    make_name 'Honda'
    make_nice_name 'honda'
    cmodel_name 'Civic'
    cmodel_nice_name 'civic'
    year 2008
  end
end
