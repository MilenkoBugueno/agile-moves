class Tomato < ActiveRecord::Base
  attr_accessible :body, :end_time, :start_time, :state, :title, :user_id, :move_id, :publish_date, :name
  belongs_to :move
  belongs_to :user
  has_one :rating
  
  scope :by_user_id, lambda {|uid| where(["#{table_name}.user_id =?", uid])}
  scope :by_date, lambda {|uid| where(["#{table_name}.publish_date =?", uid])}
  scope :by_project_id, lambda {|uid| joins(:move).where(["moves.project_id =?", uid])}
  scope :not_closed , lambda { where("#{table_name}.state != ?", 2)}

end
    