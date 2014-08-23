# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :medium do
    title "MyString"
    description "MyText"
    artist "MyString"
    composer "MyString"
    arranger "MyString"
    writer "MyString"
    catalog "MyString"
    publisher "MyString"
    state_id 1
  end
end
