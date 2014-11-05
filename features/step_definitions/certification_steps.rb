
### UTILITY METHODS ###


### GIVEN ###

Given(/^I am registered to (.*)$/) do |cert_short_name|
  certification = Certification.find_or_create_by_label(:label => cert_short_name)
  @registration = FactoryGirl.create(:registration, :user_id => @user.id, :certification_id => certification.id)

end

Given(/^(.*) nominates a move for a certification$/) do |name|
  user = User.find_or_create_by_title(:name => name)
  registration = FactoryGirl.create(:registration, :title => "Move for certification", :user_id => @user.id, :move_type_id => move_type.id)
  move_type = MoveType.find_or_create_by_title(:title => "Vision")
  move = FactoryGirl.create(:move, :title => "Move for certification", :user_id => @user.id, :move_type_id => move_type.id)


  pending
end

Given(/^I am reviewer for his certification$/) do
  pending
end

And(/^I am not registered to any certification$/) do
  #pending: when the database is setup, there are no registrations
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



And(/^fill the registration with my review team$/) do
  check "user1"
  check "user2"
  click_button "Create Registration"
end


