
### UTILITY METHODS ###




### GIVEN ###

Given(/^I am registered to (.*)$/) do |cert_short_name|
  certification = Certification.find_or_create_by_label(:label => cert_short_name)
  @registration = FactoryGirl.create(:registration, :user_id => @user.id, :certification_id => certification.id)

end

Given(/^(.*) nominates (.*) (.*) moves for (.*)$/) do |name, numb, mv_tp, cert|
  user = create_user_by_name(name)
  @nominator = FactoryGirl.create(:user, email: user[:email])
  certification = Certification.find_or_create_by_label(cert)
  @registration = FactoryGirl.create(:registration, :user_id => @nominator.id, :certification_id => certification.id)
  move_type = MoveType.find_or_create_by_title(mv_tp)
  @nominated_moves = []
  for i in 1..numb.to_i
    nominated_move = FactoryGirl.create(:move, :title => "Move for certification #{i}", :user_id => @nominator.id, :move_type_id => move_type.id, :registration_id => @registration.id)
    @nominated_moves << nominated_move
  end

end

Given(/^I am reviewer for the certification$/) do
  @me = create_user_by_name("me")
  @reviewer = FactoryGirl.create(:user, email: @me[:email])
  add_user_to_default_project(@reviewer)
  @registration.users = [@reviewer]

end

Given(/^I am not reviewer for the certification$/) do
  @me = create_user_by_name("me")
  @reviewer = FactoryGirl.create(:user, email: @me[:email])
  add_user_to_default_project(@reviewer)
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
  sign_in_as(@reviewer)
  visit '/projects/work?id=1'

end

### THEN ###



And(/^fill the registration with my review team$/) do
  check "user1"
  check "user2"
  click_button "Create Registration"
end


Then(/^I expect to see the nominated moves$/) do
  @nominated_moves.each do |move|
    page.should have_content move.title
  end
end

Then(/^I dont expect to see the nominated moves$/) do
  @nominated_moves.each do |move|
    page.should_not have_content move.title
  end
end