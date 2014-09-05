# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :registration do
    certification_id 1
    user_id 1
    start_date "2014-09-05"
    end_date "2014-09-05"
  end
end
