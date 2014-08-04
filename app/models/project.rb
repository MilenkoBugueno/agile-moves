class Project < ActiveRecord::Base
  attr_accessible :body, :title, :user_ids, :move_type_ids
  
  has_and_belongs_to_many :users
  has_many :states
  has_many :moves
  has_and_belongs_to_many :move_types


end
