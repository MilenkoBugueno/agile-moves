class Move < ActiveRecord::Base
  attr_accessible :body, :move_type_id, :user_id, :title, :user_ids, :state_id, :publish_date, :start_date, :project_id, :category_id
  validates_presence_of :title, :move_type_id
  
  belongs_to :user
  belongs_to :move_type
  belongs_to :state
  belongs_to :project
  belongs_to :category
  has_and_belongs_to_many :users
  has_many :ratings
  has_many :tomatoes
  has_many :comments


  after_create :create_objects

  after_update :update_objects

  scope :by_user_id, lambda {|uid| where(["#{table_name}.user_id =?", uid])}
  scope :by_project_id, lambda {|uid| where(["#{table_name}.project_id =?", uid])}
  scope :by_state_id, lambda {|uid| where(["#{table_name}.state_id =?", uid])}
  scope :by_move_type, lambda {|uid| where(["#{table_name}.move_type_id =?", uid])}
  scope :by_user_ids, lambda {|uid| joins(:users).where(["users.id =?", uid])}
  scope :already_reviewed, lambda {|uid| joins(:ratings).where(["ratings.user_id =?", uid])}
  scope :not_closed , lambda { where("#{table_name}.state_id != ?", State.find_or_create_by_title(:title => "closed").id)}
  
  scope :by_star_rating, lambda {joins(:move_type).where(['move_types.star_rating =?', true])}
  scope :by_thumb_rating, lambda {joins(:move_type).where(['move_types.thumb_rating =?', true])}

  after_initialize :init


  def reviewed_by_me(current_user)
    reviewed_by_me = false
    if self.move_type != nil  && self.move_type.star_rating
       self.ratings.each do |rating|
         if rating.user == current_user && rating.star_rating != -1
           reviewed_by_me = true
         end
       end
    elsif self.move_type != nil  && self.move_type.thumb_rating
      self.ratings.each do |rating|
        if rating.user == current_user && rating.thumb_rating != -1
          reviewed_by_me = true
        end
      end
    end

    return reviewed_by_me
  end

  def star_rating_by(user)
    rated_by = false
    if self.move_type != nil  && self.move_type.star_rating
      self.ratings.each do |rating|
        if rating.user == user && rating.star_rating != -1
          rated_by = true
        end
      end
    end

    return rated_by
  end

  def thumb_rating_by(user)
    rated_by = false
    if self.move_type != nil  && self.move_type.thumb_rating
      self.ratings.each do |rating|
        if rating.user == user && rating.thumb_rating != -1
          rated_by = true
        end
      end
    end

    return rated_by
  end

  def stars
    stars = 0;
    self.ratings.each do |rating|
      if rating.star_rating > 0
        stars = stars + rating.star_rating
      end
    end
    return stars
  end
  
  def rejects
    rejects = 0;
    self.ratings.each do |rating|
      if rating.star_rating == 0
        rejects = rejects + 1
      end
    end
    return rejects
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

  private
  def init
    if self.new_record? && self.state_id.nil?
      self.state_id = -1
    end
  end

  def create_objects
    move_type = self.move_type
    if move_type.make_my_day != nil && move_type.make_my_day
      tomatoes = Tomato.where("project_id = ? AND user_id = ? AND publish_date= ?", self.project_id, self.user_id, Date.today())
      tomatoes.each do |tomato|
        if tomato.state < 1 #not planned
          tomato.update_attributes(state: 1) #plan todo_today
        end
      end

    elsif move_type.tomatoes_number != nil && move_type.tomatoes_number > 0
      # check if there is already a todo_today move
      # Is a todo_today move present and the tomato is planned for today then add the tomato to the todo_today move
      # Else create a "normal" tomato move
      my_make_my_day_move = Move.where("publish_date=? AND user_id=? AND project_id=? AND move_type_id=?", self.publish_date, self.user_id, self.project_id, MoveType.find_by_make_my_day(true).id).first
      my_make_my_sprint_move = Move.where("publish_date>=? AND start_date<=? AND user_id=? AND project_id=? AND move_type_id=?", self.publish_date, self.publish_date, self.user_id, self.project_id, MoveType.find_by_make_my_sprint(true).id).first

      #create tomatoes for the tomato move
      for i in 1..move_type.tomatoes_number
        if my_make_my_day_move.present? && my_make_my_day_move.state_id == State.find_by_title("planned").id
          Tomato.create(:move_id => self.id, :title => self.title, :user_id => self.user_id, :publish_date=> self.publish_date, :state => 3, :body => self.body, :project_id => self.project_id, :user_ids => self.user_ids)
        elsif my_make_my_sprint_move.present? && my_make_my_sprint_move.state_id == State.find_by_title("planned").id
          Tomato.create(:move_id => self.id, :title => self.title, :user_id => self.user_id, :publish_date=> self.publish_date, :state => 3, :body => self.body, :project_id => self.project_id, :user_ids => self.user_ids)
        else
          Tomato.create(:move_id => self.id, :title => self.title, :user_id => self.user_id, :publish_date=> self.publish_date, :state => 0, :body => self.body, :project_id => self.project_id, :user_ids => self.user_ids)
        end

      end

    end

  end

  def update_objects
    if self.move_type.tomatoes_number == 1 && self.tomatoes.count == 1 # "only one tomato" move should update the tomato
      tomato = self.tomatoes.first
      tomato.update_attributes(:title => self.title, :user_id => self.user_id, :publish_date=> self.publish_date, :body => self.body, :project_id => self.project_id, :user_ids => self.user_ids)
    end
  end


end
