# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Environment variables (ENV['...']) can be set in the file config/application.yml.
# See http://railsapps.github.io/rails-environment-variables.html
puts 'ROLES'
YAML.load(ENV['ROLES']).each do |role|
  Role.find_or_create_by_name({ :name => role }, :without_protection => true)
  puts 'role: ' << role
end
puts 'STATES'
YAML.load(ENV['STATES']).each do |state|
  State.find_or_create_by_title({ :title => state }, :without_protection => true)
  puts 'state: ' << state
end
puts 'DEFAULT USERS'
user = User.find_or_create_by_email :name => ENV['ADMIN_NAME'].dup, :email => ENV['ADMIN_EMAIL'].dup, :password => ENV['ADMIN_PASSWORD'].dup, :password_confirmation => ENV['ADMIN_PASSWORD'].dup
puts 'user: ' << user.name
user.add_role :admin
user1 = User.find_or_create_by_email :name => "user1", :email => "user1@example.com", :password => "changeme"
puts 'user: ' << user1.name
user2 = User.find_or_create_by_email :name => "user2", :email => "user2@example.com", :password => "changeme"
puts 'user: ' << user2.name


puts 'DEFAULT WIDGETS'

plan_todo_today = Widget.find_or_create_by_title(:title => "Plan Todo Today", :path=>"projects/plan_todo_today", :widget_type => 0)

plan_sprint = Widget.find_or_create_by_title(:title => "Plan Sprint", :path=>"projects/plan_sprint", :widget_type => 0)


work_rating = Widget.find_or_create_by_title(:title => "Work rating", :path=>"projects/work_rating", :widget_type => 1)

work_tomatoes = Widget.find_or_create_by_title(:title => "Work tomatoes", :path=>"projects/work_tomatoes", :widget_type => 1)



report_rating = Widget.find_or_create_by_title(:title => "Report rating", :path=>"projects/report_rating", :widget_type => 2)

report_tomatoes = Widget.find_or_create_by_title(:title => "Report tomatoes", :path=>"projects/report_tomatoes", :widget_type => 2)


move_general = Widget.find_or_create_by_title(:title => "Move general", :path=>"moves/move_general", :widget_type => 3)

repertoire_list = Widget.find_or_create_by_title(:title => "Repertoire list", :path=>"moves/repertoire_list", :widget_type => 3)

tomatoes_timer = Widget.find_or_create_by_title(:title => "Tomatoes timer", :path=>"moves/timer", :widget_type => 3)

tomato_retro = Widget.find_or_create_by_title(:title => "Tomato retro", :path=>"moves/tomato_retro", :widget_type => 3)

tomato_rating = Widget.find_or_create_by_title(:title => "Tomato rating", :path=>"moves/tomato_rating", :widget_type => 3)

tomatoes_list = Widget.find_or_create_by_title(:title => "Tomatoes list", :path=>"moves/tomatoes_list", :widget_type => 3)

thumb_rating = Widget.find_or_create_by_title(:title => "Thumb rating", :path=>"moves/thumbrating", :widget_type => 3)

star_rating = Widget.find_or_create_by_title(:title => "Star rating", :path=>"moves/starrating", :widget_type => 3)


comments = Widget.find_or_create_by_title(:title => "Comments", :path=>"shared/comments_list", :widget_type => 3)

moves_actions = Widget.find_or_create_by_title(:title=> "Moves actions", :path=>"moves/actions", :widget_type => 3)

publish_wordpress = Widget.find_or_create_by_title(:title => "Publish wordpress", :path=>"moves/publish_wordpress", :widget_type => 3)

peer_review = Widget.find_or_create_by_title(:title => "Peer review", :path=>"moves/peer_review", :widget_type => 3)


puts 'DEFAULT MOVE TYPES'
star_move = MoveType.find_or_create_by_title :title => "Team Idea", :star_rating => true, :has_twitter_idea => true
star_move.widgets = [work_rating, report_rating, move_general, star_rating, moves_actions, comments, peer_review]
puts 'move type: ' << star_move.title

thumbs_move = MoveType.find_or_create_by_title :title => "Review", :thumb_rating => true
thumbs_move.widgets = [work_rating, report_rating, move_general, thumb_rating, moves_actions, comments, peer_review]
puts 'move type: ' << thumbs_move.title

vision_move = MoveType.find_or_create_by_title :title => "Vision", :thumb_rating => true
vision_move.widgets = [work_rating, report_rating, move_general, thumb_rating, moves_actions, comments, peer_review]
puts 'move type: ' << vision_move.title

tomatoes_move = MoveType.find_or_create_by_title :title => "Tomato", :has_tomatoes => true, :tomatoes_number => 1, :star_rating => true
tomatoes_move.widgets = [work_tomatoes, report_tomatoes, move_general, tomatoes_timer, tomato_retro, tomato_rating, star_rating, comments, moves_actions, peer_review]
puts 'move type: ' << tomatoes_move.title

teamtomatoes_move = MoveType.find_or_create_by_title :title => "Teamtomato", :has_tomatoes => true, :tomatoes_number => 1, :thumb_rating => true, :star_rating => true
teamtomatoes_move.widgets = [work_tomatoes, report_tomatoes, move_general, tomatoes_timer, tomato_retro, tomato_rating, star_rating, thumb_rating, comments, tomato_retro, moves_actions, peer_review]
puts 'move type: ' << teamtomatoes_move.title

user_story_move = MoveType.find_or_create_by_title :title => "User Story", :has_tomatoes => true, :tomatoes_number => 0, :thumb_rating => true, :star_rating => true, :is_user_story => true
user_story_move.widgets = [work_tomatoes, report_tomatoes, move_general, tomatoes_list, star_rating, thumb_rating, comments, moves_actions, peer_review]
puts 'move type: ' << user_story_move.title

todo_today_move = MoveType.find_or_create_by_title :title => "Todo Today", :has_tomatoes => true, :tomatoes_number => -1, :thumb_rating => true, :star_rating => true, :make_my_day => true
todo_today_move.widgets = [plan_todo_today, work_tomatoes, report_tomatoes, move_general, tomatoes_list, star_rating, thumb_rating, comments, moves_actions, peer_review]
puts 'move type: ' << todo_today_move.title

sprint_move = MoveType.find_or_create_by_title :title => "Sprint", :has_tomatoes => true, :tomatoes_number => -1, :thumb_rating => true, :star_rating => true, :make_my_sprint => true
sprint_move.widgets = [plan_sprint, work_tomatoes, report_tomatoes, move_general, tomatoes_list, star_rating, thumb_rating, comments, moves_actions, peer_review]
puts 'move type: ' << sprint_move.title

repertoire_move = MoveType.find_or_create_by_title :title => "Repertoire List", :thumb_rating => true, :star_rating => true, :has_media => true
repertoire_move.widgets = [work_rating, report_rating, move_general, repertoire_list, star_rating, thumb_rating, comments, moves_actions, peer_review]
puts 'move type: ' << repertoire_move.title


puts 'DEFAULT CERTIFICATIONS'
vis_03 = Certification.find_or_create_by_title :title => "Warum aufstehen?", :label => "VIS-03", :level_id => 1, :approvements => 2, :move_type_id => vision_move.id, :moves_number => 10, :duration => 30
tom_01 = Certification.find_or_create_by_title :title => "Aufdrehen - fertig - los", :label => "TOM-01", :level_id => 1, :approvements => 2, :move_type_id => tomatoes_move.id, :moves_number => 10, :duration => 30

puts 'DEFAULT REGISTRATION'
reg_vis_03 = Registration.find_or_create_by_certification_id :certification_id => vis_03.id, :user_id => user.id
vis_03.registrations = [reg_vis_03]


puts 'DEFAULT PROJECTS'
project = Project.find_or_create_by_title(:title => "Test project")
project.users = [user, user1, user2]
project.move_types = [star_move, vision_move, thumbs_move, tomatoes_move, teamtomatoes_move, user_story_move, repertoire_move, todo_today_move, sprint_move]
project.certifications = [vis_03, tom_01]
puts 'project: ' << project.title

project2 = Project.find_or_create_by_title(:title => "Test project 2")
project2.users = [user, user2]
project2.move_types = [thumbs_move, tomatoes_move]

puts 'project: ' << project2.title

