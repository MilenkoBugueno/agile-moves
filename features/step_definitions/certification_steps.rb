
### UTILITY METHODS ###


### GIVEN ###

Given(/^(.*) nominates a move for a certification$/) do |name|
  user = User.find_or_create_by_title(:name => name)
  registration = FactoryGirl.create(:registration, :title => "Move for certification", :user_id => 1, :move_type_id => move_type.id)
  move_type = MoveType.find_or_create_by_title(:title => "Vision")
  move = FactoryGirl.create(:move, :title => "Move for certification", :user_id => 1, :move_type_id => move_type.id)


  pending
end

Given(/^I am reviewer for his certification$/) do
  pending
end

And(/^A new certification is available$/) do
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


When(/^I am not registered to it$/) do
  pending
end


And(/^fill the registration with my review team$/) do
  pending
end

