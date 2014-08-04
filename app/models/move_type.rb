class MoveType < ActiveRecord::Base
  attr_accessible :body, :thumb_rating, :star_rating, :has_tomatoes, :tomatoes_number, :has_twitter_idea, :make_my_day, :make_my_sprint, :title, :project_ids, :widget_ids
  has_and_belongs_to_many :moves
  has_and_belongs_to_many :projects

  has_and_belongs_to_many :widgets

  scope :has_widget_type, lambda {|uid| joins(:widgets).where(["widgets.widget_type =?", uid])}

  def has_view(view_id)
    has_view = false
    self.widgets.each do |widget|
      if widget.widget_type == view_id
        has_view = true
      end
    end
    return has_view
  end


end
