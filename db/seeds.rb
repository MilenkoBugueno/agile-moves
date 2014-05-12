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

puts 'DEFAULT MOVE TYPES'
star_move = MoveType.find_or_create_by_title :title => "star move", :star_rating => true, :thumb_rating => false, :has_tomatoes => false
puts 'move type: ' << star_move.title
thumbs_move = MoveType.find_or_create_by_title :title => "thumb move", :thumb_rating => true, :star_rating => false, :has_tomatoes => false
puts 'move type: ' << thumbs_move.title
tomatoes_move = MoveType.find_or_create_by_title :title => "tomato move", :thumb_rating => false, :star_rating => false, :has_tomatoes => true, :tomatoes_number => 1
puts 'move type: ' << tomatoes_move.title


puts 'DEFAULT PROJECTS'
project = Project.find_or_create_by_title(:title => "Test project")
project.users = [user, user1, user2]
project.move_types = [star_move, thumbs_move, tomatoes_move]
puts 'project: ' << project.title

project2 = Project.find_or_create_by_title(:title => "Test project 2")
project2.users = [user, user2]
project2.move_types = [thumbs_move, tomatoes_move]
puts 'project: ' << project2.title
