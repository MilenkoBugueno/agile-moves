### UTILITY METHODS ###



### GIVEN ###

And(/^I am in the plan view$/) do
  visit '/'
  click_link "Test project"
  click_link "Plan"
end

### WHEN ###

When(/^I create (.*) new tomatoes$/) do |count|
  for i in 1..count.to_i
    click_link "New tomato"
    fill_in "Title", :with => "Test Tomato "+ i.to_s
    click_button "Create Tomato"
  end
end

When(/^I create (.*) new tomatoes for today$/) do |count|
  for i in 1..count.to_i
    click_link "New tomato"
    fill_in "Title", :with => "Test Tomato "+ i.to_s
    fill_in "Publish date", :with => Date.today()
    click_button "Create Tomato"
  end
end

When(/^I create (.*) new tomatoes for tomorrow$/) do |count|
  for i in 1..count.to_i
    click_link "New tomato"
    fill_in "Title", :with => "Test Tomato "+ i.to_s
    fill_in "Publish date", :with => Date.tomorrow()
    click_button "Create Tomato"
  end
end

When(/^I have a move with (.*) tomato planned for today$/) do |arg1|
  move_type = MoveType.find_or_create_by_title(:title => "Tomato")
  create_move(move_type, Date.today, 1)
end

Given(/^I have several moves with (\d+) unplanned tomatoes$/) do |arg1|
  move_type = MoveType.find_or_create_by_title(:title => "Tomato")
  create_moves(move_type, Date.today, 1, 7)
end

### THEN ###

Then(/^I see the message (.*)$/) do |message|
  page.should have_content message
end

Then(/^I see (\d+) tomatoes in the todo today list$/) do |count|
  page.should have_content "Tomato"
end

Then(/^I see (\d+) tomatoes in the activity inventory list$/) do |count|
  page.should have_content "Tomato"
end

