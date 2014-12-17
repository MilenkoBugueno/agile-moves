### UTILITY METHODS ###

def go_to_view(view)
  visit '/'
  click_link "Test project"
  click_link view
end

### GIVEN ###

Given(/^I am in the (.*) view$/) do |view|
  go_to_view(view)
end


Given(/^no sprint is planned$/) do
  delete_moves()
end

Given(/^I have (.*) moves with unplanned tomatoes$/) do |count|
  move_type = MoveType.find_or_create_by_title(:title => "Tomato")
  create_moves(move_type, Date.today, 1, count.to_i)
end


Given(/^I have (.*) moves with tomatoes planned for today$/) do |count|
  move_type = MoveType.find_or_create_by_title(:title => "Tomato")
  create_moves(move_type, Date.today, 1, count.to_i)
end

Given(/^I have (.*) moves with tomatoes planned for yesterday$/) do |count|
  move_type = MoveType.find_or_create_by_title(:title => "Tomato")
  create_moves(move_type, Date.yesterday, 1, count.to_i)
end


### WHEN ###

When(/^I create (.*) new tomatoes$/) do |count|
  for i in 1..count.to_i
    first( :link, "Tomato").click
    fill_in "Title", :with => "Tomato "+ i.to_s
    click_button "Create Move"
  end
end

When(/^I create (.*) new tomatoes for today$/) do |count|
  for i in 1..count.to_i
    first( :link, "Tomato").click
    fill_in "Title", :with => "Tomato "+ i.to_s
    fill_in "Publish date", :with => Date.today()
    click_button "Create Move"
  end
end

When(/^I create (.*) new tomatoes for tomorrow$/) do |count|
  for i in 1..count.to_i
    first( :link, "Tomato").click
    fill_in "Title", :with => "Tomato "+ i.to_s
    fill_in "Publish date", :with => Date.tomorrow()
    click_button "Create Move"
  end
end

When(/^I create a new sprint$/) do
  click_link "Create New Sprint"
  fill_in "Title", :with => "My Sprint"
  fill_in "Start date", :with => Date.today()
  fill_in "Publish date", :with => Date.today() + 1.week
  click_button "Create Move"
end

When(/^I press the button make my sprint$/) do
  click_button "Make my Sprint"
end

When(/^I press the button (.*)$/) do |title|
  click_button title
end


### THEN ###

Then(/^I see (.*) tomatoes in the todo today list$/) do |count|
  go_to_view("Plan")
  for i in 1..count.to_i()
    page.should have_content "Tomato "+ i.to_s()
  end
end

Then(/^I see (.*) tomatoes in the activity inventory list$/) do |count|
  go_to_view("Plan")
  for i in 1..count.to_i()
    page.should have_content "Tomato "+ i.to_s()
  end
end

Then(/^I see the sprint in the plan view$/) do
  go_to_view("Plan")
  page.should have_content "My Sprint"
end

Then(/^I don't see a "(.*?)" button$/) do |text|
  page.should_not have_content text
end

Then(/^the state of the move is (.*)$/) do |state|
  page.should have_content state
end