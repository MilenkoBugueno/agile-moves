
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

When(/^I click for (.*) on the button (.*)$/) do |entry, title|
  find(:xpath, "//tr[contains(.,'#{entry}')]/td/a", :text => title).click
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

Then(/^I see for (.*) the entry (.*)$/) do |key, entry|
  expect(find(:xpath, "//tr[contains(.,'#{key}')]/td/a", :text => entry)).to eq entry

end


Then(/^I see the button (.*)$/) do |title|
  page.should have_link title
end


Then(/^I land in the (.*) view$/) do |title|
  find('.breadcrumb').should have_content title
end

Then(/^I see the following entry:$/) do |expected_table|
  # table is a table.hashes.keys # => [:Short name, :Duration]
  rows = find(".table.table-striped").all('tr')
  table = rows.map { |r| r.all('th,td').map { |c| c.text.strip } }
  expected_table.diff!(table)
end
