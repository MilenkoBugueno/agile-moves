class LiveTomato < ActiveRecord::Base
  attr_accessible :currenttime, :endtime, :starttime, :title, :username, :userid, :status, :tomato_id
  belongs_to :tomato
end
