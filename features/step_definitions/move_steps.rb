### UTILITY METHODS ###

def create_tomatoes(num, date, user_id)
  @tomatoes = []
  for i in 0..num
    tomato = FactoryGirl.create(:tomato, :title => "Test tomato "+i.to_s, :publish_date => date, :user_id => user_id)
    @tomatoes << tomato
  end
end

def create_project()
  @project = FactoryGirl.create(:project, :title => "Project 1")
end


def create_move(move_type, date, user_id)
  visit '/'
  click_link "Test project"
  click_link "New Move"
  select move_type.title, :from => "Move type"
  fill_in "Title", :with => move_type.title
  click_button "Create Move"
end


### GIVEN ###

Given(/^(.*) tomatoes of me are planned for today$/) do |number|

  create_tomatoes(number.to_i, Date.today(), 1)
end

Given /^I have no moves$/ do
  Move.delete_all
end


### WHEN ###

When(/^I create a '(.*)' move$/) do |move_type|
  move_type = MoveType.find_or_create_by_title(:title => move_type)
  create_move(move_type, Date.today, 1)
end

### THEN ###

Then(/^I see a move created message$/) do
  page.should have_content "Move was successfully created"
end


Then /^I should have ([0-9]+) moves?$/ do |count|
  Move.count.should == count.to_i
end