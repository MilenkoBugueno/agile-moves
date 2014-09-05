class Certification < ActiveRecord::Base
  attr_accessible :approvements, :description, :label, :level_id, :move_type_id, :moves_number, :title, :user_id
  #level_id: 1=apprenctive; 2=journeyman; 3=master;

  validates_presence_of :title, :label, :move_type_id

  belongs_to :user
  belongs_to :move_type
  has_many :registrations

end
