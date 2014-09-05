# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :certification do
    title "MyString"
    label "MyString"
    level_id 1
    description "MyText"
    user_id 1
    move_type_id 1
    approvements 1
    moves_number 1
  end
end
