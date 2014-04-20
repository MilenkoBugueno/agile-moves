class LiveTomato < ActiveRecord::Base
  attr_accessible :currenttime, :endtime, :starttime, :title, :username, :userid, :status, :tomato_id, :star_rating, :thumb_rating
  belongs_to :tomato
end
