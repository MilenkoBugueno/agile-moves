
### UTILITY METHODS ###




### GIVEN ###

Given(/^I am registered to (.*)$/) do |cert_short_name|
  certification = Certification.find_or_create_by_label(:label => cert_short_name)
  @inscription = FactoryGirl.create(:inscription, :user_id => @user.id, :certification_id => certification.id, :start_date => Date.today())

end

Given(/^(.*) nominates (.*) (.*) moves for (.*)$/) do |name, numb, mv_tp, cert|
  user = create_user_by_name(name)
  @nominator = FactoryGirl.create(:user, email: user[:email])
  certification = Certification.find_or_create_by_label(cert)
  @inscription = FactoryGirl.create(:inscription, :user_id => @nominator.id, :certification_id => certification.id)
  move_type = MoveType.find_or_create_by_title(mv_tp)
  @nominated_moves = []
  for i in 1..numb.to_i
    nominated_move = FactoryGirl.create(:move, :title => "Move for certification #{i}", :user_id => @nominator.id, :move_type_id => move_type.id, :inscription_id => @inscription.id)
    @nominated_moves << nominated_move
  end

end

Given(/^I am reviewer for the certification$/) do
  @inscription.users = [@user]

end

Given(/^I am not reviewer for the certification$/) do
  #nothing
end


And(/^I am not registered to any certification$/) do
  #pending: when the database is setup, there are no registrations
  inscriptions = Inscription.destroy_all
end


And(/^my certification has (\d+) nominated (.*) moves$/) do |num, mv_tp|
  move_type = MoveType.find_or_create_by_title(mv_tp)
  @nominated_moves = []
  for i in 1..num.to_i
    nominated_move = FactoryGirl.create(:move, :title => "Move for certification #{i}", :user_id => @user.id, :move_type_id => move_type.id, :inscription_id => @inscription.id)
    @nominated_moves << nominated_move
  end
end

And(/^my certification has (\d+) approved (.*) moves$/) do |num, mv_tp|
  move_type = MoveType.find_or_create_by_title(mv_tp)
  @nominated_moves = []
  for i in 1..num.to_i
    nominated_move = FactoryGirl.create(:move, :title => "Move for certification #{i}", :user_id => @user.id, :move_type_id => move_type.id, :inscription_id => @inscription.id)
    FactoryGirl.create(:rating, :thumb_rating => 1, :user_id=> 2, :move_id => nominated_move.id) #approval 1
    FactoryGirl.create(:rating, :thumb_rating => 1, :user_id=> 3, :move_id => nominated_move.id) #approval 2
    @nominated_moves << nominated_move
  end
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

When(/^I'm creating a new (.*) certification$/) do |mv_tp|
  move_type = MoveType.find_or_create_by_title(mv_tp)
  click_link "New"
  fill_in "Title", :with => "Certification " + move_type.title
  fill_in "Short name", :with => "CER-01"
  select move_type.title, :from => "Move type"

end

When(/^fill the registration with my review team$/) do
  check "user1"
  check "user2"
  click_button "Create Inscription"
end

When(/^fill the registration with the start date '(.*)'$/) do |date|
  fill_in "Certification start", :with => date
  click_button "Create Inscription"
end


### THEN ###


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


Then(/^I see for (.*) in the progress bar '(.*)\/(.*)'$/) do |cert, progress, total|
  result = find('tr', text: cert)
  expect(result.find('div.progress-bar')['aria-valuenow']).to eq(progress)
end

Then(/^I can set the duration of the certification$/) do
  page.should have_content "Duration"
end


And(/^I see for (.*) the duration '(.*)'$/) do |cert, range|
  rows = find(".table.table-striped").all('tr')
  table = rows.map { |r| r.all('th,td').map { |c| c.text.strip } }
  for i in 1..(table.size-1)
    row = table[i]
    if row[2] == cert
      cert_row = i
    end

  end

  certification = table[1]
  duration = certification[5]
  duration.should have_content range

end