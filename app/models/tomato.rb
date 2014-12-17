class Tomato < ActiveRecord::Base
  attr_accessible :body, :results, :end_time, :start_time, :state, :title, :user_id, :move_id, :publish_date, :name, :project_id, :user_ids, :move_type_id
  belongs_to :move
  belongs_to :user
  has_one :rating
  has_many :comments
  belongs_to :project
  has_and_belongs_to_many :users
  belongs_to :move_type


  after_update :update_objects

  scope :by_user_id, lambda {|uid| where(["#{table_name}.user_id =?", uid])}
  scope :by_user_ids, lambda {|uid| joins(:move) & Move.by_user_ids(uid)}
  scope :by_date, lambda {|uid| where(["#{table_name}.publish_date =?", uid])}
  scope :by_project_id, lambda {|uid| where(["#{table_name}.project_id =?", uid])}
  scope :not_closed , lambda { where("#{table_name}.state != ? AND #{table_name}.state != ?", 2, 4)}

  def self.my_team_tomatoes(uid)
    where(["users.id =?", uid])
  end

  private

  def update_objects
    if self.move.present?
      move = Move.find(self.move_id)
      if move.tomatoes.count == 1
        Move.skip_callbacks = true # for multiple records
        move.update_attributes(:title => self.title, :user_id => self.user_id, :publish_date=> self.publish_date, :body => self.body, :project_id => self.project_id, :user_ids => self.user_ids)
        Move.skip_callbacks = false # reset
      end

    end
  end

end
    