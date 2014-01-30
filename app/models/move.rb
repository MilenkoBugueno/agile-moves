class Move < ActiveRecord::Base
  attr_accessible :body, :move_type_id, :state_id, :title, :user_id
end
