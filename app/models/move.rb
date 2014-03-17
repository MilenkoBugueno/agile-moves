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
  scope :by_project_id, lambda {|uid| where(['project_id =?', uid])}
  scope :by_state_id, lambda {|uid| where(['state_id =?', uid])}
  scope :by_move_type, lambda {|uid| where(['move_type_id =?', uid])}
  scope :by_user_ids, lambda {|uid| joins(:users).where(['users.id =?', uid])}
  scope :already_reviewed, lambda {|uid| joins(:ratings).where(['ratings.user_id =?', uid])}
  
  scope :by_star_rating, lambda {joins(:move_type).where(['star_rating =?', true])}
  scope :by_thumb_rating, lambda {joins(:move_type).where(['thumb_rating =?', true])}
  
  def stars
    stars = 0;
    self.ratings.each do |rating|
      if rating.star_rating > 0
        stars = stars + rating.star_rating
      end
    end
    return stars
  end
  
  def thumbs_up
    thumbs_up = 0;
    self.ratings.each do |rating|
      if rating.thumb_rating == 1
        thumbs_up = thumbs_up + 1
      end
    end
    return thumbs_up
  end
  
  def thumbs_down
    thumbs_down = 0;
    self.ratings.each do |rating|
      if rating.thumb_rating == 0
        thumbs_down = thumbs_down + 1
      end
    end
    return thumbs_down
  end
  
  def comments
    comments = 0;
    self.ratings.each do |rating|
      if rating.thumb_rating == -1 || rating.star_rating == -1
        comments = comments + 1
      end
    end
    return comments
  end
  
end
