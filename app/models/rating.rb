class Rating < ActiveRecord::Base
  attr_accessible :body, :move_id, :star_rating, :thumb_rating, :user_id
end
