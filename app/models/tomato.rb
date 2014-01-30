class Tomato < ActiveRecord::Base
  attr_accessible :body, :end_time, :start_time, :state, :title, :user_id, :move_id
  belongs_to :move
  belongs_to :user
  
  def done
  end
end
