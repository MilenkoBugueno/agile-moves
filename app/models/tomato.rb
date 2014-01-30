class State < ActiveRecord::Base
  attr_accessible :body, :position, :title, :visibility
  has_and_belongs_to_many :moves
end
