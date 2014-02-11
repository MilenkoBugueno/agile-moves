class Interruption < ActiveRecord::Base
  attr_accessible :body, :interruption_type, :tomato_id, :user_id
end
