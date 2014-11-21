class Inscription < ActiveRecord::Base
  attr_accessible :certification_id, :end_date, :project_id, :start_date, :user_id
end
