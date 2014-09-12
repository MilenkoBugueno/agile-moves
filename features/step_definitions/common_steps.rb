
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


### THEN ###
Then(/^I see the menu entry (.*)$/) do |entry|
  page.should have_content entry
end

Then(/^I see the message (.*)$/) do |message|
  page.should have_content message
end
