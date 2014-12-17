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
  first(:link, move_type.title).click
  fill_in "Title", :with => move_type.title + " " +num.to_s
  click_button "Create Move"
end

def nominate_move(move_type, date, user_id, num, reg)
  visit '/'
  click_link "Test project"
  first(:link, move_type.title).click
  click_link "Nominate"
  find('#move_inscription_id').find(:xpath, 'option[2]').select_option
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

Given(/^I have a active sprint with (\d+) done and (\d+) not done tomatoes$/) do |done_no, notdone_no|
  @sprint_move = FactoryGirl.create(:move, :title => "Sprint 1", :user_id => @user.id,
                                    :move_type_id => MoveType.find_or_create_by_title("Sprint").id,
                                    :state_id => State.find_or_create_by_title(:title => "planned").id,
                                    :start_date => Date.yesterday(),
                                    :publish_date => Date.tomorrow()
  )
  move_type = MoveType.find_or_create_by_title("Tomato")
  @done_tomatoes = []
  @notdone_tomatoes = []
  for i in 1..done_no.to_i()
    done_tomato = FactoryGirl.create(:move, :title => "Done Tomato #{i}", :user_id => @user.id, :move_type_id => move_type.id, :publish_date=> Date.yesterday())
    @done_tomatoes << done_tomato
  end

  for i in 1..notdone_no.to_i()
    notdone_tomato = FactoryGirl.create(:move, :title => "Not Done Tomato #{i}", :user_id => @user.id, :move_type_id => move_type.id, :publish_date=> Date.yesterday())
    @notdone_tomatoes << notdone_tomato
  end

end



### WHEN ###


When(/^I'm creating a '(.*)' move$/) do |move_type|
  move_type = MoveType.find_or_create_by_title(:title => move_type)
  visit '/projects/work?id=1'
  first(:link, move_type.title).click

end

When(/^I nominate a '(.*)' move to (.*)$/) do |move_type, certification|
  move_type = MoveType.find_or_create_by_title(:title => move_type)
  cert = Certification.find_or_create_by_label(certification)
  reg = Inscription.find_by_certification_id(cert.id)
  nominate_move(move_type, Date.today, @user.id, 1, reg)

end



When(/^I create a '(.*)' move$/) do |move_type|
  move_type = MoveType.find_or_create_by_title(:title => move_type)
  create_move(move_type, Date.today, 1, 1)
end

When(/^I delete the '(.*)' move in the move view$/) do |move_type|
  move_type = MoveType.find_or_create_by_title(:title => move_type)
  click_link "#{move_type.title} 1"
  click_link "Delete"
end

### THEN ###

Then(/^I see a move created message$/) do
  page.should have_content "Move was successfully created"
end

Then(/^I see a move deleted message$/) do
  page.should have_content "Move was successfully deleted"
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



Then(/^I see (\d+) not done tomatoes$/) do |count|
  for i in 1..count.to_i()
    page.should have_content "Not Done Tomato "+ i.to_s()
  end
end