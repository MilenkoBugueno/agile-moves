# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tomato do
    body "MyText"
    end_time ""
    start_time ""
    state 1
    title "MyString"
    user_id 1
  end
end
