### UTILITY METHODS ###


def create_tomatoes(num, date, user_id)
  @tomatoes = []
  for i in 0..num
    tomato = FactoryGirl.create(:tomato, :title => "Test tomato "+i.to_s, :publish_date => date, :user_id => user_id)
    @tomatoes << tomato
  end
end

def delete_tomatoes()
  @tomatoes = Tomato.all
  @tomatoes.each do |tomato|
    tomato.destroy
  end
end

def delete_moves()
  @moves = Move.all
  @moves.each do |move|
    move.destroy
  end
end

def create_project()
  @project = FactoryGirl.create(:project, :title => "Project 1")
end


def create_move(move_type, date, user_id, num)
  visit '/'
  click_link "Test project"
  first(:link, "New " + move_type.title).click
  select move_type.title, :from => "Move type"
  fill_in "Title", :with => move_type.title + " " +num.to_s
  click_button "Create Move"
end

def nominate_move(move_type, date, user_id, num, reg)
  visit '/'
  click_link "Test project"
  first(:link, "New " + move_type.title).click
  click_link "Nominate"
  find('#move_registration_id').find(:xpath, 'option[2]').select_option
  fill_in "Title", :with => move_type.title + " " +num.to_s
  click_button "Create Move"
end

def create_moves(move_type, date, user_id, count)
  for i in 1..count
    create_move(move_type, date, user_id, i)
  end
end

### GIVEN ###

Given(/^(.*) tomatoes of me are planned for today$/) do |number|
  sign_in_as_first_user()
  delete_tomatoes()
  create_tomatoes(number.to_i, Date.today(), 1)
end

Given /^I have no moves$/ do
  sign_in_as_first_user()
  Move.delete_all
end



### WHEN ###


When(/^I'm creating a '(.*)' move$/) do |move_type|
  move_type = MoveType.find_or_create_by_title(:title => move_type)
  visit '/projects/work?id=1'
  first(:link, "New " + move_type.title).click

end

When(/^I nominate a '(.*)' move to (.*)$/) do |move_type, certification|
  move_type = MoveType.find_or_create_by_title(:title => move_type)
  cert = Certification.find_or_create_by_label(certification)
  reg = Registration.find_by_certification_id(cert.id)
  nominate_move(move_type, Date.today, @user.id, 1, reg)

end



When(/^I create a '(.*)' move$/) do |move_type|
  move_type = MoveType.find_or_create_by_title(:title => move_type)
  create_move(move_type, Date.today, 1, 1)
end

### THEN ###

Then(/^I see a move created message$/) do
  page.should have_content "Move was successfully created"
end

And(/^I see '(.*)' tomatoes in the tomatoes list widget$/) do |count|
  for i in 1..count.to_i()
    page.should have_content "Test tomato "+ i.to_s()
  end

end

And(/^I see the '(.*)' move$/) do |title|
  page.should have_content title
end


Then /^I should have ([0-9]+) moves?$/ do |count|
  Move.count.should == count.to_i
end

