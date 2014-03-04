class MoveType < ActiveRecord::Base
  attr_accessible :body, :thumb_rating, :star_rating, :has_tomatoes, :has_twitter_idea, :title
  has_and_belongs_to_many :moves
end
