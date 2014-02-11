# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :interruption do
    body "MyText"
    interruption_type 1
    user_id ""
    tomato_id 1
  end
end
