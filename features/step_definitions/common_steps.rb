
### UTILITY METHODS ###


### GIVEN ###
Given(/^I am in the (.*) page$/) do |entry|
  visit '/'
  click_link entry
end


### WHEN ###
When(/^I click in the navigation bar on (.*)$/) do |entry|
  visit '/'
  click_link entry
end

When(/^I click on the button (.*)$/) do |title|
  first( :link, title).click
end

When(/^I go to my (.*) view$/) do |view|
  visit '/'
  click_link "Test project"
  click_link view

end


### THEN ###
Then(/^I see the menu entry (.*)$/) do |entry|
  page.should have_content entry
end

Then(/^I see the entry (.*)$/) do |entry|
  page.should have_content entry
end

Then(/^I see the message (.*)$/) do |message|
  page.should have_content message
end


Then(/^I see the button (.*)$/) do |title|
  page.should have_link title
end

