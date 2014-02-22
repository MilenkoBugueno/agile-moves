class Tomato < ActiveRecord::Base
  attr_accessible :body, :end_time, :start_time, :state, :title, :user_id, :move_id
  belongs_to :move
  belongs_to :user
  has_many :interruptions
  
  scope :by_user_id, lambda {|uid| where(["#{table_name}.user_id =?", uid])}
  scope :todo_today, lambda { joins(:move).where(['moves.state_id =1'])}
  
  def done
  end
end
    