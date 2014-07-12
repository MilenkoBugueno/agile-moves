### UTILITY METHODS ###



### GIVEN ###

And(/^I am in the plan view$/) do
  visit '/'
  click_link "Test project"
  click_link "Plan"
end

### WHEN ###

When(/^I create a new tomato$/) do
  click_link "New tomato"
  fill_in "Title", :with => "Test Tomato"
  click_button "Create Tomato"
end


### THEN ###

Then(/^I see a (.*) message$/) do |message|
  page.should have_content message
end