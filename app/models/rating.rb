class Rating < ActiveRecord::Base
  attr_accessible :body, :star_rating, :thumb_rating, :user_id, :move_id
  belongs_to :move
  belongs_to :user
end
