class Registration < ActiveRecord::Base
  attr_accessible :certification_id, :end_date, :start_date, :user_id

  validates_presence_of :certification_id, :user_id

  belongs_to :user
  belongs_to :certification
end
