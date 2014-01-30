# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :state do
    body "MyText"
    position 1
    title 1
    visibility 1
  end
end
