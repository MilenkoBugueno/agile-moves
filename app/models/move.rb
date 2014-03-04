class Move < ActiveRecord::Base
  attr_accessible :body, :move_type_id, :user_id, :title, :user_ids, :state_id, :publish_date, :project_id
  validates_presence_of :title, :move_type_id
  
  belongs_to :user
  belongs_to :move_type
  belongs_to :state
  belongs_to :project
  has_and_belongs_to_many :users
  has_many :ratings
  has_many :tomatoes
  
  scope :by_user_id, lambda {|uid| where(['user_id =?', uid])}
  scope :by_state_id, lambda {|uid| where(['state_id =?', uid])}
  scope :by_move_type, lambda {|uid| where(['move_type_id =?', uid])}
  scope :by_user_ids, lambda {|uid| joins(:users).where(['users.id =?', uid])}
  scope :already_reviewed, lambda {|uid| joins(:ratings).where(['ratings.user_id =?', uid])}
  
  scope :twitter_idea, lambda {joins(:move_type).where(['has_twitter_idea =?', true])}
end
