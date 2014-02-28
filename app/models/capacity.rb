class Capacity < ActiveRecord::Base
  attr_accessible :publish_date, :tomatoes_capacity, :user_id
  
  belongs_to :user
  
end
