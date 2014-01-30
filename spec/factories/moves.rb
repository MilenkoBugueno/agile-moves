# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :move do
    body "MyText"
    move_type_id 1
    user_id 1
    title "MyText"
    state_id 1
  end
end
