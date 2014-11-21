# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :inscription do
    certification_id 1
    start_date "2014-11-21"
    end_date "2014-11-21"
    user_id 1
    project_id 1
  end
end
