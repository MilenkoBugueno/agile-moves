class Registration < ActiveRecord::Base
  attr_accessible :certification_id, :end_date, :start_date, :user_id
end
