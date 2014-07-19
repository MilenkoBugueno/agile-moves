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


### THEN ###

Then(/^I see the message (.*)$/) do |message|
  page.should have_content message
end

And(/^I see (\d+) tomatoes in the todo today list$/) do |count|
  page.should have_content "Tomato"
end

And(/^I see (\d+) tomatoes in the activity inventory list$/) do |count|
  page.should have_content "Tomato"
end