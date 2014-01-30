class Tomato < ActiveRecord::Base
  attr_accessible :body, :end_time, :move_id, :start_time, :state, :title, :user_id
end
