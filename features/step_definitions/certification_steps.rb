
### UTILITY METHODS ###


### GIVEN ###

Given(/^(.*) nominates a move for a certification$/) do |name|
  pending
end

Given(/^I am reviewer for his certification$/) do
  pending
end

### WHEN ###
When(/^I create (.*) new certifications$/) do |count|
  for i in 1..count.to_i
    click_link "New"
    fill_in "Title", :with => "Certification "+ i.to_s
    fill_in "Short name", :with => "CER-0"+ i.to_s
    select "Team Idea", :from => "Move type"
    click_button "Create Certification"
  end
end


When(/^I go to my work view$/) do
  pending
end

### THEN ###


Then(/^I expect to see the nominated move$/) do
  pending
end