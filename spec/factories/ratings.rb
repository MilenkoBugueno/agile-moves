# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :rating do
    body "MyText"
    star_rating 1
    thumb_rating 1
    user_id 1
    move_id 1
  end
end
