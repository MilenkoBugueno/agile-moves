# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :move_type do
    body "MyText"
    thumb_rating false
    star_rating false
    has_tomatoes false
    title "MyString"
  end
end
