class Registration < ActiveRecord::Base
  attr_accessible :certification_id, :end_date, :start_date, :user_id, :user_ids

  validates_presence_of :certification_id, :user_id

  belongs_to :user
  belongs_to :certification
  has_many :moves
  has_and_belongs_to_many :users

  scope :by_move_type_id, lambda {|uid| joins(:certification).where(["certifications.move_type_id =?", uid])}

end
