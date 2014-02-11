class Interruption < ActiveRecord::Base
  attr_accessible :body, :interruption_type, :tomato_id, :user_id
  
  belongs_to :tomato
  belongs_to :user
  
end
