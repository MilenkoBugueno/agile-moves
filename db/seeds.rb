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
work_rating = Widget.find_or_create_by_title(:title => "Work rating", :path=>"projects/work_rating", :widget_type => 1)

work_tomatoes = Widget.find_or_create_by_title(:title => "Work tomatoes", :path=>"projects/work_tomatoes", :widget_type => 1)

work_todo_today = Widget.find_or_create_by_title(:title => "Work Todo Today", :path=>"projects/work_todo_today", :widget_type => 1)


report_rating = Widget.find_or_create_by_title(:title => "Report rating", :path=>"projects/report_rating", :widget_type => 2)

report_tomatoes = Widget.find_or_create_by_title(:title => "Report tomatoes", :path=>"projects/report_tomatoes", :widget_type => 2)


move_general = Widget.find_or_create_by_title(:title => "Move general", :path=>"moves/move_general", :widget_type => 3)

tomatoes_timer = Widget.find_or_create_by_title(:title => "Tomatoes timer", :path=>"moves/timer", :widget_type => 3)

thumb_rating = Widget.find_or_create_by_title(:title => "Thumb rating", :path=>"moves/thumbrating", :widget_type => 3)

star_rating = Widget.find_or_create_by_title(:title => "Star rating", :path=>"moves/starrating", :widget_type => 3)

tomato_retro = Widget.find_or_create_by_title(:title => "Tomato retro", :path=>"moves/tomato_retro", :widget_type => 3)

tomato_rating = Widget.find_or_create_by_title(:title => "Tomato rating", :path=>"moves/tomato_rating", :widget_type => 3)

comments = Widget.find_or_create_by_title(:title => "Comments", :path=>"shared/comments_list", :widget_type => 3)

moves_actions = Widget.find_or_create_by_title(:title=> "Moves actions", :path=>"moves/actions", :widget_type => 3)

publish_wordpress = Widget.find_or_create_by_title(:title => "Publish wordpress", :path=>"moves/publish_wordpress", :widget_type => 3)


puts 'DEFAULT MOVE TYPES'
star_move = MoveType.find_or_create_by_title :title => "Team Idea", :star_rating => true
star_move.widgets = [work_rating, report_rating, move_general, star_rating, moves_actions, comments]
puts 'move type: ' << star_move.title

thumbs_move = MoveType.find_or_create_by_title :title => "Review", :thumb_rating => true
thumbs_move.widgets = [work_rating, report_rating, move_general, thumb_rating, moves_actions, comments]
puts 'move type: ' << thumbs_move.title

vision_move = MoveType.find_or_create_by_title :title => "Vision", :thumb_rating => true
vision_move.widgets = [work_rating, report_rating, move_general, thumb_rating, moves_actions, comments]
puts 'move type: ' << vision_move.title

tomatoes_move = MoveType.find_or_create_by_title :title => "Tomato", :has_tomatoes => true, :tomatoes_number => 1
tomatoes_move.widgets = [work_tomatoes, report_tomatoes, move_general, tomatoes_timer, tomato_rating, comments, moves_actions]
puts 'move type: ' << tomatoes_move.title

teamtomatoes_move = MoveType.find_or_create_by_title :title => "Teamtomato", :has_tomatoes => true, :tomatoes_number => 1, :thumb_rating => true, :star_rating => true
teamtomatoes_move.widgets = [work_tomatoes, report_tomatoes, move_general, tomatoes_timer, star_rating, thumb_rating, comments, tomato_retro, moves_actions]
puts 'move type: ' << teamtomatoes_move.title


todo_today_move = MoveType.find_or_create_by_title :title => "Todo Today", :has_tomatoes => true, :tomatoes_number => 1, :thumb_rating => true, :star_rating => true
todo_today_move.widgets = [work_todo_today, report_tomatoes, move_general, tomatoes_timer, star_rating, thumb_rating, comments, tomato_retro, moves_actions]
puts 'move type: ' << todo_today_move.title


puts 'DEFAULT PROJECTS'
project = Project.find_or_create_by_title(:title => "Test project")
project.users = [user, user1, user2]
project.move_types = [star_move, thumbs_move, tomatoes_move,teamtomatoes_move, todo_today_move]
puts 'project: ' << project.title

project2 = Project.find_or_create_by_title(:title => "Test project 2")
project2.users = [user, user2]
project2.move_types = [thumbs_move, tomatoes_move]
puts 'project: ' << project2.title

