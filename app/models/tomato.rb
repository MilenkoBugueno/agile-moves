class Tomato < ActiveRecord::Base
  attr_accessible :body, :end_time, :start_time, :state, :title, :user_id, :move_id, :publish_date
  belongs_to :move
  belongs_to :user
  has_many :interruptions
  
  scope :by_user_id, lambda {|uid| where(["#{table_name}.user_id =?", uid])}
  scope :by_date, lambda {|uid| where(["#{table_name}.publish_date =?", uid])}
  
  def done
  end
end
    