class Rating < ActiveRecord::Base
  attr_accessible :body, :star_rating, :thumb_rating, :user_id, :move_id
  validates_presence_of :star_rating, :thumb_rating
  
  belongs_to :move
  belongs_to :user
  
  after_initialize :init
 
  private
    def init
      if self.new_record? && self.star_rating.nil?
        self.star_rating = -1
      end
      if self.new_record? && self.thumb_rating.nil?
        self.thumb_rating = -1
      end
    end
end
